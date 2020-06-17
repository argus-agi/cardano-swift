//
//  Transaction.swift
//  Cardano
//
//  Created by Ivan Manov on 17.06.2020.
//  Copyright © 2020 hellc. All rights reserved.
//

import Foundation

public protocol Transaction {
    var hex: String { get }
    var json: String { get }
    var id: String { get }
    var finalize: String { get }
    var fee: String { get }
    var estimateFee: String? { get }
    
    func addWitness(privateParentKey: String, addressing: TransactionAddressing, chainSettings: ChainSettings?)
    func addExternalWitness(publicParentKey: String, addressType: AddressType, witnessIndex: String)
}
