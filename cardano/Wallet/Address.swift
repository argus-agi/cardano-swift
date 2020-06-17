//
//  Address.swift
//  Cardano
//
//  Created by Ivan Manov on 17.06.2020.
//  Copyright © 2020 hellc. All rights reserved.
//

import Foundation

enum AddressType: String, Codable {
    /// change address
    case int = "Internal"
    /// receipt address
    case ext = "External"
}

struct Address: Codable {
    var address: String?
    var index: Int?
    var type: AddressType?
    var accountIndex: Int?
}
