//
//  ShelleyWalletError.swift
//  Cardano
//
//  Created by Ivan Manov on 8/8/20.
//  Copyright © 2020 hellc. All rights reserved.
//

import Foundation

public struct ShelleyWalletError: Codable, Error {
    /// A descriptive error message.
    let message: String?

    /// A specific error code for this error, more precise than HTTP ones.
    let code: String?
}
