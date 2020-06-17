//
//  CardanoProvider.swift
//  Cardano
//
//  Created by Ivan Manov on 17.06.2020.
//  Copyright © 2020 hellc. All rights reserved.
//

import Foundation

public struct CardanoTransaction {
    var id: String?
    var inputs: [TransactionInput]?
    var outputs: [TransactionOutput]?
}

public protocol CardanoProvider: Provider {
    func submit(signed transaction: String, completion: @escaping (_ succeed: Bool) -> Void)
    func queryUtxos(by addresses: [String], completion: @escaping (_ utxos: [Utxo]) -> Void)
    func queryTransactions(by addresses: [String], completion: @escaping (_ transactions: [CardanoTransaction]) -> Void)
    func queryTransactions(by ids: [String], completion: @escaping (_ transactions: [Any]) -> Void)
}
