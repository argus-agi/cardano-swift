//
//  Explorer.swift
//  Cardano
//
//  Created by Ivan Manov on 8/16/20.
//  Copyright © 2020 hellc. All rights reserved.
//

import CatalystNet

public extension Cardano.Rest.Explorer {
    class Blocks: Cardano.Rest.Api {}
    class Transactions: Cardano.Rest.Api {}
    class Addresses: Cardano.Rest.Api {}
    class Epochs: Cardano.Rest.Api {}
    class Genesis: Cardano.Rest.Api {}
}
