//
//  ShelleyWalletApi.swift
//  Cardano
//
//  Created by Ivan Manov on 8/8/20.
//  Copyright © 2020 hellc. All rights reserved.
//

import CatalystNet

/// Shelley Cardano Wallet Api
public class ShelleyWalletApi: Api {
    /// Sinbgleton
    public static let shared = ShelleyWalletApi()

    /// Shelley wallet Rest cleint property
    public var client: ShelleyWalletClient!

    init(client: ShelleyWalletClient = ShelleyWalletClient(host: "http://localhost", port: 8090)) {
        self.client = client
    }

    public func load<T, E>(_ resource: Resource<T, E>,
                           multitasking: Bool = false,
                           completion: @escaping (Result<Any, E>) -> Void) {
        var resource = resource

        resource.headers += ["Content-Type": "application/json"]

        super.load(resource, self.client, multitasking: multitasking, completion: completion)
    }
}
