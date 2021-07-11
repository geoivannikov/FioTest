//
//  Account.swift
//  FioTestApp
//
//  Created by George Ivannikov on 11.07.2021.
//

import Foundation

struct Account: Decodable {
    let name: String
    let number: Int
    let currency: String
    let balance: Double
}
