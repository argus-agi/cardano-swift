//
//  ProviderType.swift
//  Cardano
//
//  Created by Ivan Manov on 17.06.2020.
//  Copyright © 2020 hellc. All rights reserved.
//

import Foundation

public enum ProviderType {
    case cardano
    case wallet
}

public protocol Provider {
    var type: ProviderType? { get set }
}
