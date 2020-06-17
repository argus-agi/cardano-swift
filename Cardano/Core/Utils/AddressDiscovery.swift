//
//  AddressDiscovery.swift
//  Cardano
//
//  Created by Ivan Manov on 17.06.2020.
//  Copyright © 2020 hellc. All rights reserved.
//

import Foundation

public class Utils {
    // swiftlint:disable:next function_parameter_count
    static func addressDiscovery(inBounds lowerBound: Int, upperBound: Int,
                                 account: String, accountIndex: Int = 0, type: AddressType,
                                 cardano: Cardano, chainSettings: ChainSettings) -> [Address] {
        let addressIndices = [Int](repeating: 0, count: (upperBound - lowerBound + 1))
            .enumerated()
            .map { (idx, _) in
            return lowerBound + idx
        }

        return addressIndices.map { (index) -> Address in
            return cardano.address(
                publicParentKey: account, index: index, type: type,
                accountIndex: accountIndex, chainSettings: chainSettings
            )
        }
    }
}
