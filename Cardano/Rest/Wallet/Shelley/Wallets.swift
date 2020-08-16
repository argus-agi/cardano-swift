//
//  WalletsApi.swift
//  Cardano
//
//  Created by Ivan Manov on 8/8/20.
//  Copyright © 2020 hellc. All rights reserved.
//

import CatalystNet

public extension Cardano.Rest.Wallet.Shelley.Wallets {
    fileprivate struct Endpoints {
        static let wallets = "/wallets"

        static func walletStatisticsUtxos(by id: String) -> String {
            return "/wallets/\(id)/statistics/utxos"
        }

        static func wallet(by id: String) -> String {
            return "/wallets/\(id)"
        }

        static func walletPassphrase(by id: String) -> String {
            return "/wallets/\(id)/passphrase"
        }
    }

    /// Restore a wallet from a mnemonic sentence. It will create the wallet on wallet backend if none is restored yet
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
    func restore(name: String,
                 mnemonic sentence: [String],
                 mnemonic secondFactor: [String]? = nil,
                 passphrase: String,
                 address poolGap: UInt = 20,
                 completion: @escaping (_ wallet: RemoteWallet?, _ error: Error?) -> Void) {
        var resource = Resource<RemoteWallet, Cardano.Rest.ApiError>(
            path: Endpoints.wallets
        )

        resource.method = .post

        resource.params += [
            "name": name,
            "mnemonic_sentence": sentence,
            "passphrase": passphrase,
            "address_pool_gap": poolGap
        ]

        if let secondFactor = secondFactor {
            resource.params += ["mnemonic_second_factor": secondFactor]
        }

        self.load(resource) { (response) in
            if let wallet = response.value as? RemoteWallet, response.error == nil {
                completion(wallet, nil)
            } else if case .custom(let error) = response.error {
                completion(nil, error)
            } else {
                completion(nil, response.error)
            }
        }
    }

    /// Return a list of known wallets, ordered from oldest to newest.
    func list(completion: @escaping (_ wallets: [RemoteWallet]?, _ error: Error?) -> Void) {
        var resource = Resource<[RemoteWallet], Cardano.Rest.ApiError>(
            path: Endpoints.wallets
        )

        resource.method = .get

        self.load(resource) { (response) in
            if let wallets = response.value as? [RemoteWallet], response.error == nil {
                completion(wallets, nil)
            } else if case .custom(let error) = response.error {
                completion(nil, error)
            } else {
                completion(nil, response.error)
            }
        }
    }

    /// Return the UTxOs distribution across the whole wallet, in the form of a histogram.
    /// - Parameters:
    ///   - id: Wallet ID
    ///   String <hex> 40 characters
    func utxoStats(by id: String,
                   completion: @escaping (_ statsUtxos: RemoteWalletStatsUtxos?, _ error: Error?) -> Void) {
        var resource = Resource<RemoteWalletStatsUtxos, Cardano.Rest.ApiError>(
            path: Endpoints.walletStatisticsUtxos(by: id)
        )

        resource.method = .get

        self.load(resource) { (response) in
            if let statsUtxos = response.value as? RemoteWalletStatsUtxos, response.error == nil {
                completion(statsUtxos, nil)
            } else if case .custom(let error) = response.error {
                completion(nil, error)
            } else {
                completion(nil, response.error)
            }
        }
    }

    /// Wallet
    /// - Parameters:
    ///   - id: Wallet ID
    ///   String <hex> 40 characters
    func wallet(by id: String,
                completion: @escaping (_ statsUtxos: RemoteWallet?, _ error: Error?) -> Void) {
        var resource = Resource<RemoteWallet, Cardano.Rest.ApiError>(
            path: Endpoints.wallet(by: id)
        )

        resource.method = .get

        self.load(resource) { (response) in
            if let wallet = response.value as? RemoteWallet, response.error == nil {
                completion(wallet, nil)
            } else if case .custom(let error) = response.error {
                completion(nil, error)
            } else {
                completion(nil, response.error)
            }
        }
    }

    /// Delete wallet if exists
    /// - Parameters:
    ///   - id: Wallet ID
    ///   String <hex> 40 characters
    func delete(by id: String,
                completion: @escaping (_ succeeded: Bool, _ error: Error?) -> Void) {
        var resource = Resource<AnyResponse, Cardano.Rest.ApiError>(
            path: Endpoints.wallet(by: id)
        )

        resource.method = .delete

        self.load(resource) { (response) in
            if let value = response.value as? String, value.isEmpty, response.error == nil {
                completion(true, nil)
            } else if case .custom(let error) = response.error {
                completion(false, error)
            } else {
                completion(false, response.error)
            }
        }
    }

    /// Update wallet's name
    /// - Parameters:
    ///   - id: - id: Wallet ID
    ///     String <hex> 40 characters
    ///   - name: New wallet name
    ///     [ 1 .. 255 ] characters
    func updateName(by id: String,
                    name: String,
                    completion: @escaping (_ wallet: RemoteWallet?, _ error: Error?) -> Void) {
        var resource = Resource<RemoteWallet, Cardano.Rest.ApiError>(
            path: Endpoints.wallet(by: id)
        )

        resource.method = .put

        resource.params += ["name": name]

        self.load(resource) { (response) in
            if let wallet = response.value as? RemoteWallet, response.error == nil {
                completion(wallet, nil)
            } else if case .custom(let error) = response.error {
                completion(nil, error)
            } else {
                completion(nil, response.error)
            }
        }
    }

    /// Update Passphrase
    /// - Parameters:
    ///   - id: - id: Wallet ID
    ///     String <hex> 40 characters
    ///   - old: The current passphrase.
    ///     String [ 10 .. 255 ] characters
    ///   - new: A master passphrase to lock and protect the wallet for sensitive operation (e.g. sending funds).
    ///     String [ 10 .. 255 ] characters
    func updatePassphrase(by id: String,
                          old: String,
                          new: String,
                          completion: @escaping (_ succeeded: Bool, _ error: Error?) -> Void) {
        var resource = Resource<AnyResponse, Cardano.Rest.ApiError>(
            path: Endpoints.walletPassphrase(by: id)
        )

        resource.method = .put

        resource.params += [
            "old_passphrase": old,
            "new_passphrase": new
        ]

        self.load(resource) { (response) in
            if let value = response.value as? String, value.isEmpty, response.error == nil {
                completion(true, nil)
            } else if case .custom(let error) = response.error {
                completion(false, error)
            } else {
                completion(false, response.error)
            }
        }
    }
}
