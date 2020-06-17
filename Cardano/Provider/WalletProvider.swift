//
//  WalletProvider.swift
//  Cardano
//
//  Created by Ivan Manov on 17.06.2020.
//  Copyright © 2020 hellc. All rights reserved.
//

import Foundation

public protocol WalletProvider: Provider {
    func wallets(completion: @escaping (_ wallets: [RemoteWallet]?) -> Void)
    func createWallet(name: String,
                      mnemonic: String, mnemonicSecondFactor: String?,
                      passphrase: String,
                      completion: @escaping (_ wallet: RemoteWallet?) -> Void)
    func wallet(with id: String, completion: @escaping (_ wallet: RemoteWallet?) -> Void)
    func transactions(with walletId: String,
                      startDate: Date?, endDate: Date?,
                      completion: @escaping (_ transactions: [RemoteTransaction]?) -> Void)
    func createTransaction(with walletId: String, payments: [RemotePayment], passphrase: String,
                           completion: @escaping (_ transaction: RemoteTransaction?) -> Void)
    func addresses(with walletId: String,
                   state: RemoteAddressState,
                   completion: @escaping (_ addresses: [RemoteAddress]?) -> Void)
}
