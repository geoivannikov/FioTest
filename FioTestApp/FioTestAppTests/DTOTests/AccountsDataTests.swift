//
//  AccountsDataTests.swift
//  FioTestAppTests
//
//  Created by George Ivannikov on 13.07.2021.
//

import XCTest
@testable import FioTestApp

class AccountsDataTests: XCTestCase {
    func testParseAcountDataSuccess() {
        let json = "{\"accounts\": [ { \"name\": \"Test ÃºÄet\", \"number\": 2122122121, \"currency\": \"CZK\", \"balance\": 27000 }, { \"name\": \"ÃšÄet\", \"number\": 3256814755, \"currency\": \"CZK\", \"balance\": 57000 }, ] }".data(using: .utf8)!
        let accountsData = try! JSONDecoder().decode(AccountsData.self, from: json)

        XCTAssertEqual(accountsData.accounts.count, 2)
        XCTAssertEqual(accountsData.accounts.first?.name, "Test ÃºÄet")
        XCTAssertEqual(accountsData.accounts.first?.number, 2122122121)
        XCTAssertEqual(accountsData.accounts.first?.currency, "CZK")
        XCTAssertEqual(accountsData.accounts.first?.balance, 27000)
    }
    
    func testParseAcountDataFailure() {
        let json = "{\"accounts\": [ { \"name\": \"Test ÃºÄet\", \"number\": 2122122121, \"currency\": \"CZK\", \"balance\": 27000 }, { \"name\": \"ÃšÄet\", \"number\": \"3256814755\", \"currency\": \"CZK\", \"balance\": 57000 }, ] }".data(using: .utf8)!

        XCTAssertNil(try? JSONDecoder().decode(AccountsData.self, from: json))
    }
}
