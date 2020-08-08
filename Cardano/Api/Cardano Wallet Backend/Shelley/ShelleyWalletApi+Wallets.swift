//
//  ShelleyWalletApi+Wallets.swift
//  Cardano
//
//  Created by Ivan Manov on 8/8/20.
//  Copyright © 2020 hellc. All rights reserved.
//

import CatalystNet

public extension ShelleyWalletApi {
    fileprivate struct Endpoints {
        static let wallets = "/wallets"
    }

    /// Create and restore a wallet from a mnemonic sentence.
    /// - Parameters:
    ///   - name: Wallet name
    ///     String [ 1 .. 255 ] characters
    ///   - sentence: A list of mnemonic words.
    ///     Array of strings <bip-0039-mnemonic-word{english}> [ 15 .. 24 ] items
    ///   - secondFactor: An optional passphrase used to encrypt the mnemonic sentence.
    ///     Array of strings <bip-0039-mnemonic-word{english}> [ 9 .. 12 ] items
    ///   - passphrase: A master passphrase to lock and protect the wallet for sensitive operation (e.g. sending funds).
    ///     String [ 10 .. 255 ] characters
    ///   - poolGap: Number of consecutive unused addresses allowed. Default: 20.
    ///     UInt [ 10 .. 100 ]
    func wallet(name: String,
                mnemonic sentence: [String],
                mnemonic secondFactor: [String]? = nil,
                passphrase: String,
                address poolGap: UInt = 20,
                completion: @escaping (_ wallet: RemoteWallet?, _ error: Error?) -> Void) {
        var resource = Resource<RemoteWallet, ShelleyWalletError>(
            path: Endpoints.wallets
        )

        resource.method = .post

        self.load(resource) { (response) in
            if let wallet = response.value as? RemoteWallet, response.error == nil {
                completion(wallet, nil)
            } else {
                completion(nil, response.error)
            }
        }
    }
}
