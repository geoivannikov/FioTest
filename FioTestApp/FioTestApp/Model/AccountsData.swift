//
//  AccountsData.swift
//  FioTestApp
//
//  Created by George Ivannikov on 10.07.2021.
//

import Foundation

struct AccountsData {
    let accounts: [Account]
}

extension AccountsData: Decodable { }
