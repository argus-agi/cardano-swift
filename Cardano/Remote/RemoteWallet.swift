//
//  RemoteWallet.swift
//  Cardano
//
//  Created by Ivan Manov on 17.06.2020.
//  Copyright © 2020 hellc. All rights reserved.
//

import Foundation

public enum RemoteUnit: String, Codable {
    case lovelace = "lovelace"
    case ada = "ada"
}

public struct RemoteAmount: Codable {
    var quantity: Double?
    var unit: RemoteUnit?
}

public struct RemoteWalletBalance: Codable {
    let available: RemoteAmount?
    let total: RemoteAmount?
}

public struct RemoteWalletState: Codable {
    var status: String?
}

public struct RemoteWalletDelegation: Codable {
    var status: String?
    var target: String?
}

public struct RemoteWallet: Codable {
    let id: String?
    let balance: RemoteWalletBalance?
    let name: String?
    let state: RemoteWalletState?
    let delegation: RemoteWalletDelegation?
}
