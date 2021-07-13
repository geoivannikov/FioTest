//
//  AccountsViewModelTest.swift
//  FioTestAppTests
//
//  Created by George Ivannikov on 13.07.2021.
//

import XCTest
import Combine
@testable import FioTestApp
// And so on with the rest of the services
class AccountsViewModelTest: XCTestCase {
    var subscriptions: Set<AnyCancellable>!
    
    override func setUp() {
        subscriptions = Set<AnyCancellable>()
    }
    
    func testFetchAccountsNoConnection() {
        let accountsViewModel = AccountsViewModel(apiManager: ApiManagerMock(accountsData: nil,
                                                                             error: nil),
                                                  reachabilityService: ReachabilityServiceMock(isConnectedToNetwork: false))
        let testExpectation = expectation(description: "Fetch accounts")
        accountsViewModel.displayErrorAlert
            .sink(receiveValue: {
                XCTAssertEqual($0, .noConnectionError)
                testExpectation.fulfill()
            })
            .store(in: &subscriptions)
        accountsViewModel.viewDidLoad()
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testFetchAccountsDecodingError() {
        let accountsViewModel = AccountsViewModel(apiManager: ApiManagerMock(accountsData: nil,
                                                                             error: .decodingError),
                                                  reachabilityService: ReachabilityServiceMock(isConnectedToNetwork: true))
        let testExpectation = expectation(description: "Fetch accounts")
        accountsViewModel.displayErrorAlert
            .sink(receiveValue: {
                XCTAssertEqual($0, .decodingError)
                testExpectation.fulfill()
            })
            .store(in: &subscriptions)
        accountsViewModel.viewDidLoad()
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testFetchAccountsSuccess() {
        let accountsViewModel = AccountsViewModel(apiManager: ApiManagerMock(accountsData: AccountsData(accounts: [Account(name: "name",
                                                                                                                           number: 123,
                                                                                                                           currency: "CZK",
                                                                                                                           balance: 10.0)]),
                                                                             error: nil),
                                                  reachabilityService: ReachabilityServiceMock(isConnectedToNetwork: true))
        let testExpectation = expectation(description: "Fetch accounts")
        accountsViewModel.accounts
            .sink(receiveValue: {
                XCTAssertEqual($0.count, 1)
                XCTAssertEqual($0.first?.name, "name")
                XCTAssertEqual($0.first?.number, 123)
                XCTAssertEqual($0.first?.currency, "CZK")
                XCTAssertEqual($0.first?.balance, 10.0)
                testExpectation.fulfill()
            })
            .store(in: &subscriptions)
        accountsViewModel.viewDidLoad()
        waitForExpectations(timeout: 0.1, handler: nil)
    }
}
