//
//  ShelleyWalletClient.swift
//  Cardano
//
//  Created by Ivan Manov on 8/8/20.
//  Copyright © 2020 hellc. All rights reserved.
//

import CatalystNet

/// Shelley wallet Rest cleint
public class ShelleyWalletClient: RestClient {
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
