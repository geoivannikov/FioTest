//
//  ApiManager.swift
//  FioTestApp
//
//  Created by George Ivannikov on 10.07.2021.
//

import Foundation
import Combine

protocol ApiManagerProtocol {
    func fetchData(url: URL?) -> AnyPublisher<AccountsData, APIError>
}

final class ApiManager: ApiManagerProtocol {
    private var subscriptions = Set<AnyCancellable>()

    func fetchData(url: URL?) -> AnyPublisher<AccountsData, APIError> {
        Future<AccountsData, APIError> { [weak self] promise in
            guard let self = self else {
                return promise(.failure(.unknownError))
            }
            guard let url = url else {
                return promise(.failure(.urlError(URLError(URLError.unsupportedURL))))
            }
            URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { data, response -> AccountsData in
                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                        throw APIError.responseError((response as? HTTPURLResponse)?.statusCode ?? 500)
                    }
                    return try JSONDecoder().decode(AccountsData.self, from: data)
                }
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { (completion) in
                    if case let .failure(error) = completion {
                        switch error {
                        case let urlError as URLError:
                            promise(.failure(.urlError(urlError)))
                        case let decodingError as DecodingError:
                            promise(.failure(.decodingError(decodingError)))
                        case let apiError as APIError:
                            promise(.failure(apiError))
                        default:
                            promise(.failure(.genericError))
                        }
                    }
                }, receiveValue: {
                    promise(.success($0))
                })
                .store(in: &self.subscriptions)
        }
        .eraseToAnyPublisher()
    }
}
