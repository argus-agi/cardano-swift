//
//  WalletsTests.swift
//  CardanoTests
//
//  Created by Ivan Manov on 17.06.2020.
//  Copyright © 2020 hellc. All rights reserved.
//

import XCTest
import CatalystNet
@testable import Cardano

class WalletsApiTests: XCTestCase {
    private var walletsApi: Cardano.Rest.Wallet.Shelley.Wallets!
    
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
        self.walletsApi = Cardano.Rest.Wallet.Shelley.Wallets()
        self.walletsApi.client = RestClient(baseUrl: "http://pool.kxp.one:8090/v2")
    }

    func testMnemonic() throws {
        let result1 = Mnemonic.isValid(phrase: self.validMnemonic)
        XCTAssertTrue(result1)
        
        let result2 = Mnemonic.isValid(phrase: self.invalidMnemonic)
        XCTAssertFalse(result2)
    }
    
    func testRestoreWallet() {
        let expectation = self.expectation(description: "RestoreWallet")
        
        self.walletsApi.restore(name: "Test",
                                      mnemonic: self.validMnemonic,
                                      passphrase: "TestWallet") { (wallet, error) in
            if let error = error as? Cardano.Rest.ApiError {
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
        
        self.walletsApi.list() { (wallets, error) in
            XCTAssertTrue(((wallets?.contains(where: { $0.id == "9e37dbdbb2e4c99cdf92fedaaadea7a3aac8c574" })) != nil))
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testWalletStatsUtxos() {
        let expectation = self.expectation(description: "Wallet Stats Utxos")
        
        self.walletsApi.utxoStats(by: "9e37dbdbb2e4c99cdf92fedaaadea7a3aac8c574") { (statsUtxos, error) in
            XCTAssertTrue(statsUtxos?.total?.quantity == 1000000)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testWalletById() {
        let expectation = self.expectation(description: "Wallet by id")
        
        self.walletsApi.wallet(by: "9e37dbdbb2e4c99cdf92fedaaadea7a3aac8c574") { (wallet, error) in
            XCTAssertTrue(wallet?.id == "9e37dbdbb2e4c99cdf92fedaaadea7a3aac8c574")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testWalletNameUpdate() {
        let expectation = self.expectation(description: "Wallet update name")
        
        self.walletsApi.updateName(by: "9e37dbdbb2e4c99cdf92fedaaadea7a3aac8c574",
                                         name: "TestUpdated") { (wallet, error) in
            XCTAssertTrue(wallet?.name == "TestUpdated")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testWalletPassphraseUpdate() {
        let expectation1 = self.expectation(description: "Wallet update passphrase valid")
        
        self.walletsApi.updatePassphrase(by: "9e37dbdbb2e4c99cdf92fedaaadea7a3aac8c574",
                                               old: "TestWallet",
                                               new: "TestWallet") { (succeeded, error) in
            XCTAssertTrue(succeeded)
            expectation1.fulfill()
        }
        
        let expectation2 = self.expectation(description: "Wallet update passphrase invalid")
        
        self.walletsApi.updatePassphrase(by: "9e37dbdbb2e4c99cdf92fedaaadea7a3aac8c574",
                                               old: "WrongPassphrase",
                                               new: "TestWallet") { (succeeded, error) in
            XCTAssertFalse(succeeded)
            expectation2.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
