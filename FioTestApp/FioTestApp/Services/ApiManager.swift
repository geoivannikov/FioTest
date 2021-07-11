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
//        URLSession.shared.dataTaskPublisher(for: url)
//            .map(\.data)
//            .decode(type: AccountsData.self, decoder: JSONDecoder())
//            .eraseToAnyPublisher()
        
        Future<AccountsData, Error> { [unowned self] promise in
//            guard let url = url else {
//                return promise(.failure(.urlError(URLError(URLError.unsupportedURL))))
//            }
//            URLSession.shared.dataTaskPublisher(for: url)
//                            .tryMap { (data, response) -> Data in
//                                guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
//                                    throw MovieStoreAPIError.responseError((response as? HTTPURLResponse)?.statusCode ?? 500)
//                                }
//                                return data
//                        }
        }
        .eraseToAnyPublisher()
        
    }
//    func fetchMovies(from endpoint: Endpoint) -> Future<[Movie], MovieStoreAPIError> {
//      return Future<[Movie], MovieStoreAPIError> {[unowned self] promise
//        //...
//        self.urlSession.dataTaskPublisher(for: url)
//          .tryMap { (data, response) -> Data in
//           // ...
//        }
//        .decode(type: MoviesResponse.self, decoder: self.jsonDecoder)
//        .receive(on: RunLoop.main)
//        .sink(receiveCompletion: { (completion) in
//          if case let .failure(error) = completion
//            switch error {
//              case let urlError as URLError:
//                promise(.failure(.urlError(urlError)))
//              case let decodingError as DecodingError:
//                promise(.failure(.decodingError(decodingError)))
//              case let apiError as MovieStoreAPIError:
//                promise(.failure(apiError))
//              default:
//                promise(.failure(.genericError))
//            }
//          }
//        }, receiveValue: { promise(.success($0.results)) })
//      }
//    }
}
