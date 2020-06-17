//
//  RemoteTransaction.swift
//  Cardano
//
//  Created by Ivan Manov on 17.06.2020.
//  Copyright © 2020 hellc. All rights reserved.
//

import Foundation

public enum RemoteTransactionDirection: String, Codable {
    case outgoing
    case incoming
}

public struct RemoteTransactionTime: Codable {
    var time: String?
    var block: RemoteTransactionBlock?
}

public struct RemoteTransactionBlock: Codable {
    var slotNumber: UInt?
    var epochNumber: UInt?

    private enum CodingKeys: String, CodingKey {
        case slotNumber = "slot_number"
        case epochNumber = "epoch_number"
    }
}

public struct RemoteTransaction: Codable {
    var id: String?
    var amount: RemoteAmount?
    var insertedAt: RemoteTransactionTime?
    var depth: RemoteAmount?
    var direction: RemoteTransactionDirection?
    var inputs: [RemotePayment]?
    var outputs: [RemotePayment]?
    var status: String?

    private enum CodingKeys: String, CodingKey {
        case id, amount, depth, direction, inputs, outputs, status
        case insertedAt = "inserted_at"
    }
}
