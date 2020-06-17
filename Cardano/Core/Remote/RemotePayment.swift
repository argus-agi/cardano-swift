//
//  RemotePayment.swift
//  Cardano
//
//  Created by Ivan Manov on 17.06.2020.
//  Copyright © 2020 hellc. All rights reserved.
//

import Foundation

public struct RemotePayment: Codable {
    var address: String?
    var amount: RemoteAmount?
}
