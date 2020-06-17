//
//  Wallet.swift
//  Cardano
//
//  Created by Ivan Manov on 17.06.2020.
//  Copyright © 2020 hellc. All rights reserved.
//

import Foundation

public struct TransactionsResponse: Codable {
    var id: String?
}

public protocol WalletInstance {
    func nextReceivingAddress(completion: @escaping (_ address: Address?) -> Void)
    func nextChangeAddress(completion: @escaping (_ address: Address?) -> Void)
    func balance(completion: @escaping (_ balance: Double?) -> Void)
    func transactions(completion: @escaping (_ balance: Double?) -> Void)
}

typealias WalletConstructor = (_ publicParentKey: String?,
    _ chainSettings: ChainSettings?,
    _ walletId: String?) -> WalletInstance
