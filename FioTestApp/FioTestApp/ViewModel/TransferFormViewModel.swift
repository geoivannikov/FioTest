//
//  TransferFormViewModel.swift
//  FioTestApp
//
//  Created by George Ivannikov on 11.07.2021.
//

import Foundation
import Combine

protocol TransferFormViewModelProtocol {
    var account: Account { get }
    var sendTransfer: PassthroughSubject<TransferData, Never> { get }
}

final class TransferFormViewModel: TransferFormViewModelProtocol {
    let account: Account
    let sendTransfer = PassthroughSubject<TransferData, Never>()
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(account: Account, fileService: FileServiceProtocol? = Env.current.fileService) {
        self.account = account
        
        sendTransfer
            .sink(receiveValue: { transferData in
                fileService?.saveData(to: "transfers", "txt", content: "bla")
            })
            .store(in: &subscriptions)
    }
}
