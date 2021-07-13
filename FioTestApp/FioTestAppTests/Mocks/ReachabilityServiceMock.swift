//
//  ReachabilityServiceMock.swift
//  FioTestAppTests
//
//  Created by George Ivannikov on 13.07.2021.
//

import Foundation
@testable import FioTestApp

final class ReachabilityServiceMock: ReachabilityServiceProtocol {
    let isConnectedToNetwork: Bool
    
    init(isConnectedToNetwork: Bool) {
        self.isConnectedToNetwork = isConnectedToNetwork
    }
}
