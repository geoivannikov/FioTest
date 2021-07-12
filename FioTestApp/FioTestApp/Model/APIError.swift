//
//  APIError.swift
//  FioTestApp
//
//  Created by George Ivannikov on 11.07.2021.
//

import Foundation

enum APIError: Error {
    case urlError(URLError)
    case responseError(Int)
    case decodingError(DecodingError)
    case genericError
    case unknownError
}
