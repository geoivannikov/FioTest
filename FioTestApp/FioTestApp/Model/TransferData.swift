//
//  TransferData.swift
//  FioTestApp
//
//  Created by George Ivannikov on 11.07.2021.
//

import Foundation

struct TransferData {
    let accountName: String
    let currency: String
    let recipientNumber: String
    let amount: Double
    let variableSymbol: Int?
}

extension TransferData: Codable { }
