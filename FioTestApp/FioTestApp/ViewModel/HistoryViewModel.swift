//
//  HistoryViewModel.swift
//  FioTestApp
//
//  Created by George Ivannikov on 11.07.2021.
//

import Foundation

protocol HistoryViewModelProtocol {
    var transfers: [TransferData] { get }
}

final class HistoryViewModel: HistoryViewModelProtocol {
    let transfers: [TransferData]
    
    init(fileService: FileServiceProtocol? = Env.current.fileService) {
        transfers = fileService?.retrieveData(from: Constants.fileName, "txt")?.split(whereSeparator: \.isNewline)
            .compactMap { $0.data(using: .utf8) }
            .compactMap { try? JSONDecoder().decode(TransferData.self, from: $0) }
            .reversed() ?? []
    }
}
