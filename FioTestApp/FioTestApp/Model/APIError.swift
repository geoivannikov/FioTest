//
//  APIError.swift
//  FioTestApp
//
//  Created by George Ivannikov on 11.07.2021.
//

import Foundation

enum APIError: Error {
    case urlError
    case responseError
    case decodingError
    case genericError
    case noConnectionError
    case unknownError
}

extension APIError: LocalizedError {
    var description: String? {
        switch self {
        case .urlError:
            return "Incorrect URL"
        case .responseError:
            return "Response error"
        case .decodingError:
            return "Decoding failed"
        case .genericError:
            return "Generic error"
        case .noConnectionError:
            return "No internet connection. Establish connection and relaunch the application"
        case .unknownError:
            return "Unknown error"
        }
    }
}
