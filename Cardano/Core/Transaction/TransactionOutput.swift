//
//  TransactionOutput.swift
//  Cardano
//
//  Created by Ivan Manov on 17.06.2020.
//  Copyright © 2020 hellc. All rights reserved.
//

import Foundation

public protocol TransactionRequiredFields: Codable {
    var address: String? { get set }
    var value: String? { get set }
}

public struct TransactionCadAmount: Codable {
    var getCCoin: Double? //?
}

public struct TransactionFullAddress: Codable {
    let cadAmount: TransactionCadAmount?
    let cadId: String?
    let cadIsUsed: Bool?
    let change: Int?
    let index: Int?
}

public protocol TransactionOptionalFields: Codable {
    var isChange: Bool? { get set }
    var fullAddress: TransactionFullAddress? { get set }
}

public struct TransactionOutput: Codable, TransactionRequiredFields, TransactionOptionalFields {
    // MARK: TransactionRequiredFields

    public var address: String?
    public var value: String?

    // MARK: TransactionOptionalFields

    public var isChange: Bool?
    public var fullAddress: TransactionFullAddress?
}
