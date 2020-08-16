//
//  CardanoWallet.swift
//  Cardano
//
//  Created by Ivan Manov on 8/9/20.
//  Copyright © 2020 hellc. All rights reserved.
//

import Foundation

/// Shared entry point
public extension Cardano.Rest.Wallet {
    class Shelley {}
}

public extension Cardano.Rest.Wallet.Shelley {
    class Wallets: Cardano.Rest.Api {}
    class Addresses: Cardano.Rest.Api {}
    class CoinSelections: Cardano.Rest.Api {}
    class Transactions: Cardano.Rest.Api {}
    class Migrations: Cardano.Rest.Api {}
    class StakePools: Cardano.Rest.Api {}
}
