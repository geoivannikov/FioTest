//
//  TransferFormViewModel.swift
//  FioTestApp
//
//  Created by George Ivannikov on 11.07.2021.
//

import Foundation

protocol TransferFormViewModelProtocol {
    var account: Account { get }
}

final class TransferFormViewModel: TransferFormViewModelProtocol {
    let account: Account
    
    init(account: Account) {
        self.account = account
    }
}
