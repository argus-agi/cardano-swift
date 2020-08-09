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
    
    func testRestoreWallet() {
        let expectation = self.expectation(description: "RestoreWallet")
        
        ShelleyWalletApi.shared.walletRestore(name: "Test",
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
        let expectation = self.expectation(description: "Wallet Stats Utxos")
        
        ShelleyWalletApi.shared.walletStatsUtxos(by: "9e37dbdbb2e4c99cdf92fedaaadea7a3aac8c574") { (statsUtxos, error) in
            XCTAssertTrue(statsUtxos?.total?.quantity == 1000000)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testWalletById() {
        let expectation = self.expectation(description: "Wallet by id")
        
        ShelleyWalletApi.shared.wallet(by: "9e37dbdbb2e4c99cdf92fedaaadea7a3aac8c574") { (wallet, error) in
            XCTAssertTrue(wallet?.id == "9e37dbdbb2e4c99cdf92fedaaadea7a3aac8c574")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testWalletNameUpdate() {
        let expectation = self.expectation(description: "Wallet update name")
        
        ShelleyWalletApi.shared.walletName(by: "9e37dbdbb2e4c99cdf92fedaaadea7a3aac8c574",
                                           name: "TestUpdated") { (wallet, error) in
            XCTAssertTrue(wallet?.name == "TestUpdated")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testWalletPassphraseUpdate() {
        let expectation1 = self.expectation(description: "Wallet update passphrase valid")
        
        ShelleyWalletApi.shared.walletPassphrase(by: "9e37dbdbb2e4c99cdf92fedaaadea7a3aac8c574",
                                                 old: "TestWallet",
                                                 new: "TestWallet") { (succeeded, error) in
            XCTAssertTrue(succeeded)
            expectation1.fulfill()
        }
        
        let expectation2 = self.expectation(description: "Wallet update passphrase invalid")
        
        ShelleyWalletApi.shared.walletPassphrase(by: "9e37dbdbb2e4c99cdf92fedaaadea7a3aac8c574",
                                                 old: "WrongPassphrase",
                                                 new: "TestWallet") { (succeeded, error) in
            XCTAssertFalse(succeeded)
            expectation2.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}
