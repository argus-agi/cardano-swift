//
//  Cardano.swift
//  Cardano
//
//  Created by Ivan Manov on 17.06.2020.
//  Copyright © 2020 hellc. All rights reserved.
//

import Foundation

public struct CardanoAccount: Codable {
    let privateParentKey: String
    let publicParentKey: String
}

public struct CardanoSignedMessage: Codable {
    let signature: String
    let publicKey: String
}

public protocol Cardano {
    func buildTransaction(inputs: [TransactionInput],
                          outputs: [TransactionOutput],
                          feeAlgorithm: FeeAlgorithm?) -> Transaction
    func account(mnemonic: String, passphrase: String, accountIndex: Int) -> CardanoAccount
    func address(publicParentKey: String,
                 index: Int,
                 type: AddressType,
                 accountIndex: Int,
                 chainSettings: ChainSettings?) -> Address
    func signMessage(privateParentKey: String,
                     addressType: AddressType,
                     signingIndex: Int,
                     message: String) -> CardanoSignedMessage
    func verifyMessage(publicKey: String, message: String, signature: String) -> Bool
    func inputSelection(outputs: [TransactionOutput],
                        utxoSet: [AddressingUtxo],
                        changeAddress: String,
                        feeAlgorithm: FeeAlgorithm?) -> TransactionSelection
}
