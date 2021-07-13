//
//  TransferDataTests.swift
//  FioTestAppTests
//
//  Created by George Ivannikov on 13.07.2021.
//

import XCTest
@testable import FioTestApp

class TransferDataTests: XCTestCase {
    func testEncodeAcountDataSuccess() {
        let transferData = TransferData(accountName: "name",
                                        currency: "CZK",
                                        recipientNumber: "2222",
                                        amount: 112.0,
                                        variableSymbol: 1234)
        let transferDataEncoded = try! JSONEncoder().encode(transferData)
        let transferDataEncodedString = String(data: transferDataEncoded, encoding: .utf8)
        XCTAssertEqual(transferDataEncodedString, "{\"amount\":112,\"currency\":\"CZK\",\"recipientNumber\":\"2222\",\"accountName\":\"name\",\"variableSymbol\":1234}")
    }
}
