//
//  CardanoManager.h
//  cardano-ios
//
//  Created by Ivan Manov on 23/11/2018.
//
//------------------------------------------//

#import <Foundation/Foundation.h>

//------------------------------------------//

#pragma mark - Consts

#define XPRV_SIZE 96
#define TXID_SIZE 32

#pragma mark - Types

/// Result type, where 0 is success and !0 is failure
typedef enum : int {
    CardanoResultSuccess = 0,
    CardanoResultFailure = 1,
} CardanoResult;

#pragma mark - Keys types

/// Pointer to an Extended Private Key
typedef struct CardanoXprv CardanoXprv;

/// Pointer to an Extended Public Key
typedef struct CardanoXpub CardanoXpub;

#pragma mark - Addresses types

/// Pointer to a (parsed) Extended Address
typedef struct CardanoAddress CardanoAddress;

#pragma mark - Wallet types

/// Pointer to an Account
typedef struct CardanoAccount CardanoAccount;

/// Pointer to a Wallet
typedef struct CardanoWallet CardanoWallet;

#pragma mark - Transactions types

/// Pointer to a Transaction builder
typedef struct CardanoTransactionBuilder CardanoTransactionBuilder;

/// Pointer to a Transaction finalized
typedef struct CardanoTransactionFinalized CardanoTransactionFinalized;

/// Pointer to a Transaction output pointer
typedef struct CardanoTxoptr CardanoTxoptr;

/// Pointer to a Transaction output
typedef struct CardanoTxoutput CardanoTxoutput;

/// Pointer to a Transaction
typedef struct CardanoTransaction CardanoTransaction;

/// Pointer to a signed Transaction
typedef struct CardanoSignedTransaction CardanoSignedTransaction;

//------------------------------------------//

NS_ASSUME_NONNULL_BEGIN

@interface CardanoManager : NSObject

+ (instancetype)shared;

#pragma mark - Utility functions for handling the private master key
#pragma mark - BIP39 context methods

/**
 Encode a entropy into its equivalent words represented by their index (0 to 2047) in the BIP39 dictionary
 
 @param entropy raw entropy
 @param completion (result - encode result, mnemonicIndex - the encoded entropy, mnemonicSize - mnemonic size)
 */
- (void)bip39EncodeWithEntropyRaw:(NSString *)entropy
                   withCompletion:(void(^)(CardanoResult result,
                                           unsigned short mnemonicIndex,
                                           unsigned long mnemonicSize))completion;

#pragma mark - Keys context methods

/**
 Get public key from the private one
 
 @param privkey private key
 @return return public key
 */
- (CardanoXpub *)keysPublicKeyFromPrivateKey:(CardanoXprv *)privkey;

/**
 Get private key from 96 size byte array
 
 @param bytes byte array
 @return return private key
 */
- (CardanoXprv *)keysPrivateKeyFromBytes:(uint8_t[XPRV_SIZE])bytes;

/**
 Get byte array of size 96 for private key
 
 @param privkey private key
 @return return bytes
 */
- (uint8_t *)keysPrivateKeyToBytes:(CardanoXprv *)privkey;

/**
 Delete private key
 
 @param privkey private key pointer
 @return return public key
 */
- (CardanoXpub *)keysDeletePrivateKey:(CardanoXprv *)privkey;

/**
 Delete public key
 
 @param pubkey public key pointer
 @return return public key
 */
- (CardanoXpub *)keysDeletePublicKey:(CardanoXpub *)pubkey;

#pragma mark - Utility functions to work with addresses
#pragma mark - Addresses context methods

/**
 Check if an address is a valid protocol address.
 
 @param base58Address base58 address string
 @return return returns whether or not it's a valid base58 address
 */
- (BOOL)addressesValidateBase58Address:(NSString *)base58Address;

/**
 Generates new address from public key
 
 @param publickey public key
 @return return address
 */
- (CardanoAddress *)addressesNewAddressFromPublicKey:(CardanoXpub *)publickey;

/**
 Delete address
 
 @param address address pointer to delete
 */
- (void)addressesDeleteAddress:(CardanoAddress *)address;

/**
 Convert address pointer to base58 string
 
 @param address address pointer
 @return return base58 address string
 */
- (NSString *)addressesExportBase58FromAddress:(CardanoAddress *)address;

/**
 Convert base58 address string to address pointer
 
 @param base58Address base58 address string
 @return return address pointer
 */
- (CardanoAddress *)addressesImportAddressFromBase58:(NSString *)base58Address;

#pragma mark - Utility functions to work with wallet and accounts
#pragma mark - Wallet context methods

/**
 Create wallet from entroty
 
 @param entropy entropy data
 @param password password string
 @return return wallet pointer
 */
- (CardanoWallet *)walletWithEntropy:(NSData *)entropy andPassword:(NSString *)password;

/**
 Delete wallet
 
 @param wallet wallet pointer
 */
- (void)walletDelete:(CardanoWallet *)wallet;

/**
 Create account for wallet
 
 @param wallet wallet pointer
 @param alias account alias / name
 @param index account index (based on accounts number)
 @return return account pointer
 */
- (CardanoAccount *)walletCreateAccountForWallet:(CardanoWallet *)wallet
                                       withAlias:(NSString *)alias
                                    accountIndex:(NSUInteger)index;

/**
 Delete wallet account
 
 @param account account pointer
 */
- (void)walletDeleteAccount:(CardanoAccount *)account;


/**
 Generate addresses for account

 @param account account pointer
 @param internal internal description?
 @param fromIndex start index
 @param numIndices numIndices description?
 @return return addresses pointers
 */
- (char **)walletGenerateAddressesForAccount:(CardanoAccount *)account
                                      internal:(NSInteger)internal
                                     fromIndex:(NSUInteger)fromIndex
                                    numIndices:(NSUInteger)numIndices;

#pragma mark - Utility functions to create and sign transactions over transaction builder
#pragma mark - Transaction context methods

/**
 New transaction output pointer

 @param txId transaction id
 @param index transaction index
 @return return transaction output pointer
 */
- (CardanoTxoptr *)transactionNewTxOutputPtrWithTxId:(uint8_t[TXID_SIZE])txId index:(uint32_t)index;

/**
 Delete transaction output pointer

 @param txOutputPtr transaction output pointer
 */
- (void)transactionDeleteTxOutputPtr:(CardanoTxoptr *)txOutputPtr;

/**
 New transaction output

 @param address transaction address pointer
 @param value output value
 @return return transaction output
 */
- (CardanoTxoutput *)transactionNewTxOutputForAddress:(CardanoAddress *)address
                                                value:(uint64_t)value;

/**
 Delete translaction output

 @param txOutput transaction output
 */
- (void)transactionDeleteTxOutput:(CardanoTxoutput *)txOutput;

/**
 Create new transaction builder

 @return return transaction builder
 */
- (CardanoTransactionBuilder *)transactionNewTxBuilder;

/**
 Delete transaction builder

 @param txBuilder transaction builder
 */
- (void)transactionDeleteTxBuilder:(CardanoTransactionBuilder *)txBuilder;

/**
 Add transaction output pointer to transaction builder

 @param txOutputPtr transaction output pointer
 @param txBuilder transaction builder
 */
- (void)transactionAddOutputTx:(CardanoTxoptr *)txOutputPtr
                   byTxBuilder:(CardanoTransactionBuilder *)txBuilder;

/**
 Add transaction input to transaction output pointer by transaction builder

 @param inputValue transaction input value
 @param txOutputPtr transaction output pointer
 @param txBuilder transaction builder
 @return return result type
 */
- (CardanoResult)transactionAddInput:(uint64_t)inputValue
                       toTxOutputPtr:(CardanoTxoptr *)txOutputPtr
                         byTxBuilder:(CardanoTransactionBuilder *)txBuilder;

/**
 Change transaction address for transaction builder

 @param changeAddress transaction address
 @param txBuilder transaction builder
 @return return result type
 */
- (CardanoResult)transactionChangeAddress:(CardanoAddress *)changeAddress
                              forTxBuilder:(CardanoTransactionBuilder *)txBuilder;

/**
 Calculate transaction fee from transaction builder

 @param txBuilder transaction builder
 @return return transaction fee
 */
- (uint64_t)transactionTxFeeFromTxBuilder:(CardanoTransactionBuilder *)txBuilder;

/**
Result transaction from transaction builder

 @param txBuilder transaction builder
 @return return final transaction
 */
- (CardanoTransaction *)transactionResultTxFromTxBuilder:(CardanoTransactionBuilder *)txBuilder;

/**
 Finalize result transaction

 @param txResult result transaction from transaction builder
 @return return finalized transaction
 */
- (CardanoTransactionFinalized *)transactionFinalizedTxFromTxResult:(CardanoTransaction *)txResult;

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
                                            toFinalizedTx:(CardanoTransactionFinalized *)finalizedTx;

/**
 Sign finalized (with witness) transaction

 @param finalizedTx finalized transaction
 @return return signed transactiob
 */
- (CardanoSignedTransaction *)transactionSignedTxFromFinalizedTx:(CardanoTransactionFinalized *)finalizedTx;

@end

NS_ASSUME_NONNULL_END

//------------------------------------------//
