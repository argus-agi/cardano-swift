//
//  LocalKeyManager.swift
//  Cardano
//
//  Created by Ivan Manov on 18.06.2020.
//  Copyright © 2020 hellc. All rights reserved.
//

import Foundation

extension String: Error {}

public class LocalKeyManager: KeyManager {
    private let cardano: Cardano
    private let mnemonic: String
    private let password: String
    private let accountIndex: Int
    private let account: CardanoAccount

    public init(cardano: Cardano, mnemonic: String, password: String, accountIndex: Int = 0) throws {
        if !Mnemonic.isValid(phrase: mnemonic.components(separatedBy: " ")) {
            throw "InvalidMnemonic"
        }

        self.cardano = cardano
        self.mnemonic = mnemonic
        self.password = password
        self.accountIndex = accountIndex

        self.account = cardano.account(mnemonic: mnemonic, passphrase: password, accountIndex: accountIndex)
    }

    // MARK: KeyManager

    public var publicParentKey: String {
        return self.account.publicParentKey
    }

    public func sign(transaction: Transaction,
                     inputs: [TransactionInput],
                     chainSettings: ChainSettings?,
                     completion: @escaping (String?) -> Void) {
        DispatchQueue.global(qos: .default).async {
            inputs.forEach { input in
                transaction.addWitness(
                    privateParentKey: self.account.privateParentKey,
                    addressing: input.addressing,
                    chainSettings: .mainnet
                )
            }

            DispatchQueue.main.async {
                completion(transaction.finalize)
            }
        }
    }

    public func sign(message: String,
                     addressType: AddressType,
                     signingIndex: Int,
                     completion: @escaping (CardanoSignedMessage?) -> Void) {
        DispatchQueue.global(qos: .default).async {
            let signedMessage = self.cardano.signMessage(
                privateParentKey: self.account.privateParentKey,
                addressType: addressType,
                signingIndex: signingIndex,
                message: message
            )

            DispatchQueue.main.async {
                completion(signedMessage)
            }
        }
    }
}
