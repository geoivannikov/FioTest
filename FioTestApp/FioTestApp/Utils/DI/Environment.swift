//
//  Environment.swift
//  FioTestApp
//
//  Created by George Ivannikov on 10.07.2021.
//

import Foundation

struct Environment {
    var apiManager: ApiManagerProtocol = ApiManager()
    var reachabilityService: ReachabilityServiceProtocol = ReachabilityService()
    var fileManager: FileManagerProtocol = FileManager()
}
