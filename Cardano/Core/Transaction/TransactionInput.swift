//
//  TransactionInput.swift
//  Cardano
//
//  Created by Ivan Manov on 17.06.2020.
//  Copyright © 2020 hellc. All rights reserved.
//

import Foundation

public struct TransactionPointer: Codable {
    let index: Int?
    let id: String?
}

public struct TransactionAddressing: Codable {
    let change: Int?
    let index: Int?
    let accountIndex: Int?
}

public struct TransactionValue: Codable {
    let address: String?
    let value: String?
}

public struct TransactionInput: Codable {
    let pointer: TransactionPointer
    let value: TransactionValue
    let addressing: TransactionAddressing
}
