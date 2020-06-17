//
//  KeyManager.swift
//  Cardano
//
//  Created by Ivan Manov on 17.06.2020.
//  Copyright © 2020 hellc. All rights reserved.
//

import Foundation

public protocol KeyManager {
    func sign(transaction: Transaction,
              inputs: [TransactionInput], chainSettings: ChainSettings?,
              completion: @escaping (_ signedTransaction: String?) -> Void)
    func sign(message: String, addressType: AddressType, signingIndex: Int,
              completion: @escaping (_ signedMessage: CardanoSignedMessage?) -> Void)
    var publicParentKey: String { get }
}
