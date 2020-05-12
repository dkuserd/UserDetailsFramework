//
//  EncryptDecryptHandler.swift
//  UserDetailsFramework
//
//  Created by Dadha Kumar on 12/5/20.
//  Copyright © 2020 Dadha Kumar. All rights reserved.
//

import Foundation

class EncryptDecryptHandler: ValueTransformer {
    override class func allowsReverseTransformation() -> Bool {
        return true
    }
    override func transformedValue(_ value: Any?) -> Any? {
        guard let emailUn = value as? String else {
            return nil
        }
        return emailUn.data(using: .utf8)?.base64EncodedData()
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data, let decoded = Data(base64Encoded: data) else { return nil }
        return String(data:decoded, encoding: .utf8)
    }
}

