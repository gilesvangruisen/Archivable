//
//  Encoded.swift
//  StorableValue
//
//  Created by Giles Van Gruisen on 10/2/15.
//  Copyright © 2015 Giles Van Gruisen. All rights reserved.
//

import Foundation

public struct Encoder {

    let data: NSMutableData
    let archiver: NSKeyedArchiver

    public init() {
        data = NSMutableData()
        archiver = NSKeyedArchiver(forWritingWithMutableData: data)
    }

    public func encode<Value: Archivable>(value: Value, forKey key: String) {
        archiver.encodeObject(value.encodedData(), forKey: key)
    }

    public func encode<Value: Archivable>(value: Value) {
        value.encode(archiver)
    }

    public func encodedData() -> NSData {
        archiver.finishEncoding()
        return data
    }

}
