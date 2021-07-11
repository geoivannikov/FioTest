//
//  ApiManager.swift
//  FioTestApp
//
//  Created by George Ivannikov on 10.07.2021.
//

import Foundation
import Combine

protocol ApiManagerProtocol {
    func fetchData(url: URL) -> AnyPublisher<AccountsData, Error>
}

final class ApiManager: ApiManagerProtocol {
    func fetchData(url: URL) -> AnyPublisher<AccountsData, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: AccountsData.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
