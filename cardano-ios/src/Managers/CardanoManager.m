//
//  CardanoManager.m
//  cardano-ios
//
//  Created by Ivan Manov on 23/11/2018.
//
//------------------------------------------//

#import "CardanoManager.h"

//------------------------------------------//

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

#import "cardano.h"

//------------------------------------------//

@interface CardanoManager ()

@end

//------------------------------------------//

@implementation CardanoManager

+ (instancetype)shared {
    static id sharedSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSingleton = [[self alloc] init];
    });
    return sharedSingleton;
}

- (id)init {
    if (self = [super init]) {
    } return self;
}

#pragma mark - BIP39 context methods

/**
 Encode a entropy into its equivalent words represented by their index (0 to 2047) in the BIP39 dictionary
 
 @param entropy raw entropy
 @param completion (result - encode result, mnemonicIndex - the encoded entropy, mnemonicSize - mnemonic size)
 */
- (void)bip39EncodeWithEntropyRaw:(NSString *)entropy
                   withCompletion:(void(^)(CardanoResult result,
                                           unsigned short mnemonicIndex,
                                           unsigned long mnemonicSize))completion {
    if (!completion) return;
    
    const char * const entropyRaw = [entropy cStringUsingEncoding:NSUTF8StringEncoding];
    unsigned short *mnemonicIndex = NULL;
    unsigned long mnemonicSize = 0;
    CardanoResult result = cardano_bip39_encode(entropyRaw, entropy.length, mnemonicIndex, mnemonicSize);
    
    completion(result, *mnemonicIndex, mnemonicSize);
}

#pragma mark - Keys context methods
//
///**
// Get public key from the private one
//
// @param privkey private key
// @return return public key
// */
//- (CardanoXpub *)keysPublicKeyFromPrivateKey:(CardanoXprv *)privkey {
//    return (CardanoXpub *)cardano_xprv_to_xpub((cardano_xprv *)privkey);
//}
//
///**
// Get private key from 96 size byte array
//
// @param bytes byte array
// @return return private key
// */
//- (CardanoXprv *)keysPrivateKeyFromBytes:(uint8_t[XPRV_SIZE])bytes {
//    return (CardanoXprv *)cardano_xprv_from_bytes(bytes);
//}
//
///**
// Get byte array of size 96 for private key
//
// @param privkey private key
// @return return bytes
// */
//- (uint8_t *)keysPrivateKeyToBytes:(CardanoXprv *)privkey {
//    return cardano_xprv_to_bytes((cardano_xprv *)privkey);
//}
//
///**
// Delete private key
//
// @param privkey private key pointer
// @return return public key
// */
//- (CardanoXpub *)keysDeletePrivateKey:(CardanoXprv *)privkey {
//    return (CardanoXpub *)cardano_xprv_delete((cardano_xprv *)privkey);
//}
//
///**
// Delete public key
//
// @param pubkey public key pointer
// @return return public key
// */
//- (CardanoXpub *)keysDeletePublicKey:(CardanoXpub *)pubkey {
//    return (CardanoXpub *)cardano_xpub_delete((cardano_xpub *)pubkey);
//}

#pragma mark - Addresses context methods

/**
 Check if an address is a valid protocol address.
 
 @param base58Address base58 address string
 @return return returns whether or not it's a valid base58 address
 */
- (BOOL)addressesValidateBase58Address:(NSString *)base58Address {
    if (base58Address && [base58Address isKindOfClass:NSString.class]) {
        return !cardano_address_is_valid([base58Address cStringUsingEncoding:NSUTF8StringEncoding]);
    } return NO;
}

/**
 Generates new address from public key
 
 @param publickey public key
 @return return address
 */
- (CardanoAddress *)addressesNewAddressFromPublicKey:(CardanoXpub *)publickey {
    return (CardanoAddress *)cardano_address_new_from_pubkey((cardano_xpub *)publickey);
}

/**
 Delete address
 
 @param address address pointer to delete
 */
- (void)addressesDeleteAddress:(CardanoAddress *)address {
    cardano_address_delete((cardano_address *)address);
}

/**
 Convert address pointer to base58 string
 
 @param address address pointer
 @return return base58 address string
 */
- (NSString *)addressesExportBase58FromAddress:(CardanoAddress *)address {
    return [NSString stringWithUTF8String:cardano_address_export_base58((cardano_address *)address)];
}

/**
 Convert base58 address string to address pointer
 
 @param base58Address base58 address string
 @return return address pointer
 */
- (CardanoAddress *)addressesImportAddressFromBase58:(NSString *)base58Address {
    return  (CardanoAddress *)cardano_address_import_base58([base58Address cStringUsingEncoding:NSUTF8StringEncoding]);
}

#pragma mark - Wallet context methods

/**
 Create wallet from entroty
 
 @param entropy entropy string
 @param password password string
 @return return wallet pointer
 */
- (CardanoWallet *)walletWithEntropy:(NSData *)entropy
                         andPassword:(NSString *)password {
    
    const uint8_t * const entropyPtr = (const uint8_t *)[entropy bytes];
    return (CardanoWallet *)cardano_wallet_new(entropyPtr,
                                               entropy.length,
                                               [password cStringUsingEncoding:NSUTF8StringEncoding],
                                               password.length);
}

/**
 Delete wallet
 
 @param wallet wallet pointer
 */
- (void)walletDelete:(CardanoWallet *)wallet {
    cardano_wallet_delete((cardano_wallet *)wallet);
}

/**
 Create account for wallet
 
 @param wallet wallet pointer
 @param alias account alias / name
 @param index account index (based on accounts number)
 @return return account pointer
 */
- (CardanoAccount *)walletCreateAccountForWallet:(CardanoWallet *)wallet
                                       withAlias:(NSString *)alias
                                    accountIndex:(NSUInteger)index {
    return (CardanoAccount *)cardano_account_create((cardano_wallet *)wallet, [alias cStringUsingEncoding:NSUTF8StringEncoding], (unsigned int)index);
}

/**
 Delete wallet account
 
 @param account account pointer
 */
- (void)walletDeleteAccount:(CardanoAccount *)account {
    cardano_account_delete((cardano_account *)account);
}

/**
 Generate addresses for account
 
 @param account account pointer
 @param internal internal description?
 @param fromIndex start index
 @param numIndices numIndices description?
 @return return addresses pointers
 */
- (NSString *)walletGenerateAddressForAccount:(CardanoAccount *)account
                                      internal:(NSInteger)internal
                                     fromIndex:(NSUInteger)fromIndex
                                    numIndices:(NSUInteger)numIndices {
    
    char *addresses_ptr = NULL;
    cardano_account_generate_addresses((cardano_account *)account,
                                       (int)internal,
                                       (unsigned int)fromIndex,
                                       (unsigned long)numIndices,
                                       &addresses_ptr);
    return [[NSString alloc] initWithUTF8String:addresses_ptr];
}

#pragma mark - Transaction context methods

/**
 New transaction output pointer
 
 @param txId transaction id
 @param index transaction index
 @return return transaction output pointer
 */
- (CardanoTxoptr *)transactionNewTxOutputPtrWithTxId:(uint8_t[TXID_SIZE])txId index:(uint32_t)index {
    return (CardanoTxoptr *)cardano_transaction_output_ptr_new(txId, index);
}

/**
 Delete transaction output pointer
 
 @param txOutputPtr transaction output pointer
 */
- (void)transactionDeleteTxOutputPtr:(CardanoTxoptr *)txOutputPtr {
    cardano_transaction_output_ptr_delete((cardano_txoptr *)txOutputPtr);
}

/**
 New transaction output
 
 @param address transaction address pointer
 @param value output value
 @return return transaction output
 */
- (CardanoTxoutput *)transactionNewTxOutputForAddress:(CardanoAddress *)address
                                                value:(uint64_t)value {
    return (CardanoTxoutput *)cardano_transaction_output_new((cardano_address *)address, value);
}

/**
 Delete translaction output
 
 @param txOutput transaction output
 */
- (void)transactionDeleteTxOutput:(CardanoTxoutput *)txOutput {
    cardano_transaction_output_delete((cardano_txoutput *)txOutput);
}

/**
 Create new transaction builder
 
 @return return transaction builder
 */
- (CardanoTransactionBuilder *)transactionNewTxBuilder {
    return (CardanoTransactionBuilder *)cardano_transaction_builder_new();
}

/**
 Delete transaction builder
 
 @param txBuilder transaction builder
 */
- (void)transactionDeleteTxBuilder:(CardanoTransactionBuilder *)txBuilder {
    cardano_transaction_builder_delete((cardano_transaction_builder *)txBuilder);
}

/**
 Add transaction output pointer to transaction builder
 
 @param txOutputPtr transaction output pointer
 @param txBuilder transaction builder
 */
- (void)transactionAddOutputTx:(CardanoTxoptr *)txOutputPtr
                   byTxBuilder:(CardanoTransactionBuilder *)txBuilder {
    cardano_transaction_builder_add_output((cardano_transaction_builder *)txBuilder, (cardano_txoptr *)txOutputPtr);
}

/**
 Add transaction input to transaction output pointer by transaction builder
 
 @param inputValue transaction input value
 @param txOutputPtr transaction output pointer
 @param txBuilder transaction builder
 @return return result type
 */
- (CardanoResult)transactionAddInput:(uint64_t)inputValue
                       toTxOutputPtr:(CardanoTxoptr *)txOutputPtr
                         byTxBuilder:(CardanoTransactionBuilder *)txBuilder {
    return cardano_transaction_builder_add_input((cardano_transaction_builder *)txBuilder,
                                                 (cardano_txoptr *)txOutputPtr,
                                                 inputValue);
}

/**
 Change transaction address for transaction builder
 
 @param changeAddress transaction address
 @param txBuilder transaction builder
 @return return result type
 */
- (CardanoResult)transactionChangeAddress:(CardanoAddress *)changeAddress
                             forTxBuilder:(CardanoTransactionBuilder *)txBuilder {
    return cardano_transaction_builder_add_change_addr((cardano_transaction_builder *)txBuilder,
                                                       (cardano_address *)changeAddress);
}

/**
 Calculate transaction fee from transaction builder
 
 @param txBuilder transaction builder
 @return return transaction fee
 */
- (uint64_t)transactionTxFeeFromTxBuilder:(CardanoTransactionBuilder *)txBuilder {
    return cardano_transaction_builder_fee((cardano_transaction_builder *)txBuilder);
}

/**
 Result transaction from transaction builder
 
 @param txBuilder transaction builder
 @return return final transaction
 */
- (CardanoTransaction *)transactionResultTxFromTxBuilder:(CardanoTransactionBuilder *)txBuilder {
    return (CardanoTransaction *)cardano_transaction_builder_finalize((cardano_transaction_builder *)txBuilder);
}

/**
 Finalize result transaction
 
 @param txResult result transaction from transaction builder
 @return return finalized transaction
 */
- (CardanoTransactionFinalized *)transactionFinalizedTxFromTxResult:(CardanoTransaction *)txResult {
    return (CardanoTransactionFinalized *)cardano_transaction_finalized_new((cardano_transaction *)txResult);
}

/**
 Add witness to finalized transaction
 
 @param xprv private key bytes
 @param protocolMagic protocol magic byte ???
 @param txId transaction id
 @param finalizedTx finalized transaction
 @return return result type
 */
- (CardanoResult)transactionAddWitnessWithPrivateKeyBytes:(uint8_t[XPRV_SIZE])xprv
                                        withProtocolMagic:(uint32_t)protocolMagic
                                                  andTxId:(uint8_t[TXID_SIZE])txId
                                            toFinalizedTx:(CardanoTransactionFinalized *)finalizedTx {
    return cardano_transaction_finalized_add_witness((cardano_transaction_finalized *)finalizedTx,
                                                     xprv,
                                                     protocolMagic,
                                                     txId);
}

/**
 Sign finalized (with witness) transaction
 
 @param finalizedTx finalized transaction
 @return return signed transactiob
 */
- (CardanoSignedTransaction *)transactionSignedTxFromFinalizedTx:(CardanoTransactionFinalized *)finalizedTx {
    return (CardanoSignedTransaction *)cardano_transaction_finalized_output((cardano_transaction_finalized *)finalizedTx);
}

@end

//------------------------------------------//


