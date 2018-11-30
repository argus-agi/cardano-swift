//
//  ViewController.swift
//  cardano-ios-example-swift
//
//  Created by Ivan Manov on 30/11/2018.
//  Copyright © 2018 hellc. All rights reserved.
//
//---------------------------------------------------//

import UIKit

//---------------------------------------------------//

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        walletExample()
    }
    
    func walletExample() {
        var entropy: [UInt8] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
        let alias = "Test Wallet"
        
        let wallet: OpaquePointer = CardanoManager.shared().wallet(withEntropy: Data(bytes: &entropy, count: entropy.count), andPassword: "abc")
        
        let account: OpaquePointer = CardanoManager.shared().walletCreateAccount(for: wallet, withAlias: alias, accountIndex: 0)
        
        let addressString = CardanoManager.shared().walletGenerateAddress(for: account, internal: 0, from: 0, numIndices: 1)
        
        let valid = CardanoManager.shared().addressesValidateBase58Address(addressString)
        print("\(addressString) is valid: \(valid ? "YES" : "NO")")
        // Expect : Ae2tdPwUPEZFvFJcJSyoF3ReaYh67P4W8dkroJwUoeT4yAEY118WPDh5e4G is valid: YES
    }
}

//---------------------------------------------------//
