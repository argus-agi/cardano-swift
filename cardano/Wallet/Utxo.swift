//
//  Utxo.swift
//  Cardano
//
//  Created by Ivan Manov on 17.06.2020.
//  Copyright © 2020 hellc. All rights reserved.
//

import Foundation

public class Utxo: Codable {
    let address: String?
    let value: String?
    let id: String?
    let index: Int?
}

public class AddressingUtxo: Utxo {
    var addressing: TransactionAddressing?
}
