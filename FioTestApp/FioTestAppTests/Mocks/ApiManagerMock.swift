//
//  ApiManagerMock.swift
//  FioTestAppTests
//
//  Created by George Ivannikov on 13.07.2021.
//

import Foundation
import Combine
@testable import FioTestApp

final class ApiManagerMock: ApiManagerProtocol {
    let accountsData: AccountsData?
    let error: APIError?
    
    init(accountsData: AccountsData?, error: APIError?) {
        self.accountsData = accountsData
        self.error = error
    }
    
    func fetchData(url: URL?) -> AnyPublisher<AccountsData, APIError> {
        Future<AccountsData, APIError> { [weak self] promise in
            if let accountsData = self?.accountsData {
                promise(.success(accountsData))
            } else if let error = self?.error {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
}
