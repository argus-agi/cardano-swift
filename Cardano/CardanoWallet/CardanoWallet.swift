//
//  CardanoWallet.swift
//  Cardano
//
//  Created by Ivan Manov on 8/9/20.
//  Copyright © 2020 hellc. All rights reserved.
//

import CatalystNet

/// Shared entry point
public class CardanoWallet {
    public static var client: CardanoWalletClient! = CardanoWalletClient(host: "http://localhost") {
        didSet {
            CardanoWallet.wallets.client = CardanoWallet.client
        }
    }

    public static let wallets = WalletsApi()
}

/// Rest wallet client
public class CardanoWalletClient: RestClient {
    /// Cardano wallet https://github.com/input-output-hk/cardano-wallet host
    public let host: String

    /// Cardano wallet application port
    public let port: UInt

    /// Cardano wallet Rest client initialization
    /// - Parameters:
    ///   - host: Cardano wallet https://github.com/input-output-hk/cardano-wallet host
    ///   - port: Cardano wallet application port
    public init(host: String, port: UInt = 8090) {
        self.host = host
        self.port = port

        super.init(baseUrl: "\(host):\(port)/v2")
    }
}

/// Shelley Cardano Wallet Api
public class CardanoWalletApi: Api {
    /// Shelley wallet Rest cleint property
    public var client: CardanoWalletClient!

    public func load<T, E>(_ resource: Resource<T, E>,
                           multitasking: Bool = false,
                           completion: @escaping (Result<Any, E>) -> Void) {
        var resource = resource

        resource.headers += ["Content-Type": "application/json"]

        super.load(resource, self.client, multitasking: multitasking, completion: completion)
    }
}
