//
//  FileService.swift
//  FioTestApp
//
//  Created by George Ivannikov on 11.07.2021.
//

import Foundation

protocol FileServiceProtocol {
    func saveData(to fileName: String, _ pathExtension: String, content: String)
    func retrieveData(from fileName: String, _ pathExtension: String) -> String?
}

final class FileService: FileServiceProtocol {
    private let directoryURL: URL
    private var currentWritableFileHandle: FileHandle? {
        willSet {
            guard currentWritableFileHandle != newValue else { return }

            currentWritableFileHandle?.closeFile()
        }
    }
    
    init?(directoryURL: URL?) {
        guard let directoryURL = directoryURL else {
            return nil
        }

        self.directoryURL = directoryURL
    }
    
    func saveData(to fileName: String, _ pathExtension: String, content: String) {
        print("\(fileName) \(pathExtension)")
        let fileURL = directoryURL.appendingPathComponent(fileName).appendingPathComponent(pathExtension)
        print(fileURL.path)
        if !FileManager.default.fileExists(atPath: fileURL.path) {
            FileManager.default.createFile(atPath: fileURL.path, contents: nil)
        }
        currentWritableFileHandle = try! FileHandle(forWritingTo: fileURL)
        currentWritableFileHandle?.seekToEndOfFile()
        if let content = content.data(using: .utf8) {
            currentWritableFileHandle?.write(content)
        }
    }
    
    func retrieveData(from fileName: String, _ pathExtension: String) -> String? {
        let fileURL = directoryURL.appendingPathComponent(fileName).appendingPathComponent(pathExtension)
        if !FileManager.default.fileExists(atPath: fileURL.path) {
            return nil
        }
        
        do {
            return try String(contentsOf: fileURL, encoding: .utf8)
        } catch {
            return nil
        }
    }
}
