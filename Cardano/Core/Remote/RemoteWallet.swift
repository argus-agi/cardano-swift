//
//  RemoteWallet.swift
//  Cardano
//
//  Created by Ivan Manov on 17.06.2020.
//  Copyright © 2020 hellc. All rights reserved.
//

import Foundation

public struct BlockReference: Codable {
    let slotNumber: UInt?
    let epochNumber: UInt?
    let height: Amount?

    private enum CodingKeys: String, CodingKey {
        case height
        case slotNumber = "slot_number"
        case epochNumber = "epoch_number"
    }
}

public struct Epoch: Codable {
    let number: UInt?

    /// String <iso-8601-date-and-time>
    let startTime: String?

    private enum CodingKeys: String, CodingKey {
        case number = "epoch_number"
        case startTime = "epoch_start_time"
    }
}

public enum AmountUnit: String, Codable {
    case lovelace
    case ada
    case percent
}

public struct Amount: Codable {
    let quantity: Double?
    let unit: String?
}

public struct RemoteWalletBalance: Codable {
    /// Available UTxO balance (funds that can be spent without condition).
    let available: Amount?

    /// The balance of the reward account for this wallet.
    let reward: Amount?

    /// Total balance (available balance plus pending change and reward balance).
    let total: Amount?
}

public enum RemoteWalletStatus: String, Codable {
    case ready
    case syncing
    case notResponding = "not_responding"
}

public struct RemoteWalletState: Codable {
    /// Status
    let status: RemoteWalletStatus?

    /// If: status == syncing. [ 0 .. 100 ], Value: "percent"
    let progress: Amount?
}

public enum RemoteWalletDelegationStatus: String, Codable {
    case notDelegating = "not_delegating"
    case delegating
}

public struct RemoteWalletDelegation: Codable {
    /// Currently active delegation status.
    let status: RemoteWalletDelegationStatus?

    /// A unique Stake-Pool identifier (present only if status = delegating).
    /// String <hex> [ 56 .. 64 ] characters
    let target: String?

    /// Future delegation changes
    let changesAt: Epoch?

    private enum CodingKeys: String, CodingKey {
        case status, target
        case changesAt = "changes_at"
    }
}

public struct RemoteWalletDelegationSettings: Codable {
    /// Currently active delegation status.
    let active: RemoteWalletDelegation?

    /// Future delegation settings changes
    let next: [RemoteWalletDelegation]?
}

public struct RemoteWalletPassphraseInfo: Codable {
    let lastUpdatedAt: String?

    private enum CodingKeys: String, CodingKey {
        case lastUpdatedAt = "last_updated_at"
    }
}

public struct RemoteWallet: Codable {
    /// A unique identifier for the wallet.
    /// String <hex> 40 characters
    let id: String?

    /// Number of consecutive unused addresses allowed.
    /// Default: 20. UInt [ 10 .. 100 ]
    let addressPoolGap: UInt?

    /// Wallet current balance(s)
    let balance: RemoteWalletBalance?

    /// Delegation settings
    let delegation: RemoteWalletDelegationSettings?

    /// Wallet name.
    /// String [ 1 .. 255 ] characters
    let name: String?

    /// Information about the wallet's passphrase
    let passphrase: RemoteWalletPassphraseInfo?

    /// Whether a wallet is ready to use or still syncing
    let state: RemoteWalletState?

    /// A reference to a particular block.
    let tip: BlockReference?

    private enum CodingKeys: String, CodingKey {
        case id, balance, delegation, name, passphrase, state, tip
        case addressPoolGap = "address_pool_gap"
    }
}

public struct RemoteWalletStatsUtxos: Codable {
    let total: Amount?
    let scale: String?
    let distribution: [String: UInt]?
}
