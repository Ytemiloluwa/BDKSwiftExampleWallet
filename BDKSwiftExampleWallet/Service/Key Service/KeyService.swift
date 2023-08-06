//
//  KeyService.swift
//  BDKSwiftExampleWallet
//
//  Created by Matthew Ramsden on 8/4/23.
//

import Foundation
import KeychainAccess

struct KeyService {
    private let keychain = Keychain(service: "com.matthewramsden.bdkswiftexamplewallet.testservice")

    enum BackupInfoError: Error {
        case encodingError
        case writeError
        case urlError
        case decodingError
        case readError
    }
}

extension KeyService {
    
    // look at ways to encode + encrypt
    func saveBackupInfo(backupInfo: BackupInfo) throws {
        let encoder = JSONEncoder()
        let data = try encoder.encode(backupInfo)
        keychain[data: "BackupInfo"] = data
     }

    // look at ways to decode + decrypt
    func getBackupInfo() throws -> BackupInfo {
        guard let encryptedJsonData = try keychain.getData("BackupInfo") else {
            throw BackupInfoError.readError
        }
        let decoder = JSONDecoder()
        let backupInfo = try decoder.decode(BackupInfo.self, from: encryptedJsonData)
        return backupInfo
    }
        
    // remove private and use in App if want to delete
    private func deleteBackupInfo() throws {
        try keychain.remove("BackupInfo")
    }

}