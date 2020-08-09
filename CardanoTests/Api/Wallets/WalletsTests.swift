//
//  WalletsTests.swift
//  CardanoTests
//
//  Created by Ivan Manov on 17.06.2020.
//  Copyright © 2020 hellc. All rights reserved.
//

import XCTest
@testable import Cardano

class WalletsTests: XCTestCase {
    private let validMnemonic = [
        "safe", "meat", "expand", "okay", "degree", "dawn", "siren", "carpet", "tortoise", "shy", "tank",
        "once", "arena", "weasel", "drift", "boring", "beyond", "merry", "across", "steel", "bridge",
        "accuse", "suit", "traffic"
    ]
    
    private let invalidMnemonic = [
        "kxp", "meat", "expand", "okay", "degree", "dawn", "siren", "carpet", "tortoise", "shy", "tank",
        "once", "arena", "weasel", "drift", "boring", "beyond", "merry", "across", "steel", "bridge",
        "accuse", "suit", "traffic"
    ]

    override func setUpWithError() throws {
        ShelleyWalletApi.shared.client = ShelleyWalletClient(host: "http://pool.kxp.one")
    }

    func testMnemonic() throws {
        let result1 = Mnemonic.isValid(phrase: self.validMnemonic)
        XCTAssertTrue(result1)
        
        let result2 = Mnemonic.isValid(phrase: self.invalidMnemonic)
        XCTAssertFalse(result2)
    }
    
    func testCreateWallet() {
        let expectation = self.expectation(description: "CreateWallet")
        
        ShelleyWalletApi.shared.wallet(name: "Test",
                                       mnemonic: self.validMnemonic,
                                       passphrase: "TestWallet") { (wallet, error) in
            if let error = error as? ShelleyWalletError {
                XCTAssertTrue(error.code == "wallet_already_exists")
            } else {
                XCTFail("No error thrown")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testWalletsList() {
        let expectation = self.expectation(description: "Known wallets")
        
        ShelleyWalletApi.shared.wallets() { (wallets, error) in
            XCTAssertTrue(((wallets?.contains(where: { $0.id == "9e37dbdbb2e4c99cdf92fedaaadea7a3aac8c574" })) != nil))
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testWalletStatsUtxos() {
        let expectation = self.expectation(description: "Known wallets")
        
        ShelleyWalletApi.shared.walletUtxos(for: "9e37dbdbb2e4c99cdf92fedaaadea7a3aac8c574") { (statsUtxos, error) in
            XCTAssertTrue(statsUtxos?.total?.quantity == 1000000)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}
