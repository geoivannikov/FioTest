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
                guard let encodedTransferData = try? JSONEncoder().encode(transferData),
                      let transferDataString = String(data: encodedTransferData, encoding: .utf8) else {
                    return
                }
                fileService?.saveData(to: Constants.fileName, "txt", content: transferDataString + "\n")
            })
            .store(in: &subscriptions)
    }
}
