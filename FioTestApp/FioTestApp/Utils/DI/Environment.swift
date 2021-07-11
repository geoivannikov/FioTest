//
//  Environment.swift
//  FioTestApp
//
//  Created by George Ivannikov on 10.07.2021.
//

import Foundation

struct Environment {
    var transfersDirectoryURL: URL? = {
        guard let directory = try? FileManager.default.url(for: .documentDirectory,
                                                           in: .userDomainMask,
                                                           appropriateFor: nil,
                                                           create: true) else {
            return nil
        }
        let transfersDirectoryURL = directory.appendingPathComponent("userData")
        if !FileManager.default.fileExists(atPath: transfersDirectoryURL.path) {
            try? FileManager.default.createDirectory(at: transfersDirectoryURL, withIntermediateDirectories: true, attributes: nil)
        }
        return directory
    }()
    var fileService: FileServiceProtocol? {
        FileService(directoryURL: transfersDirectoryURL)
    }
    var apiManager: ApiManagerProtocol = ApiManager()
    var reachabilityService: ReachabilityServiceProtocol = ReachabilityService()
}
