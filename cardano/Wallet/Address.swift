//
//  Address.swift
//  Cardano
//
//  Created by Ivan Manov on 17.06.2020.
//  Copyright © 2020 hellc. All rights reserved.
//

import Foundation

public enum AddressType: String, Codable {
    /// change address
    case int = "Internal"
    /// receipt address
    case ext = "External"
}

public struct Address: Codable {
    let address: String?
    let index: Int?
    let type: AddressType?
    let accountIndex: Int?
}
