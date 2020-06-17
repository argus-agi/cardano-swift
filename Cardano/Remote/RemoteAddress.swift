//
//  RemoteAddress.swift
//  Cardano
//
//  Created by Ivan Manov on 17.06.2020.
//  Copyright © 2020 hellc. All rights reserved.
//

import Foundation

public enum RemoteAddressState: String, Codable {
    case used = "used"
    case unused = "unused"
}

public struct RemoteAddress: Codable {
    let id: String?
    let state: RemoteAddressState?
}
