//
//  Decoder.swift
//  StorableValue
//
//  Created by Giles Van Gruisen on 10/3/15.
//  Copyright © 2015 Giles Van Gruisen. All rights reserved.
//

import Foundation

public struct Decoder {

    let data: NSData
    let unarchiver: NSKeyedUnarchiver

    public init(data: NSData) {
        self.data = data
        unarchiver = NSKeyedUnarchiver(forReadingWithData: self.data)
    }

    public func decode<Value: Archivable>(key: String) -> Value? {
        guard let data = unarchiver.decodeObjectForKey(key) as? NSData else {
            return .None
        }

        return Value.decodedValue(data)
    }

    internal func decodeDirect<T>(decode: NSKeyedUnarchiver -> T?) -> T? {
        return decode(unarchiver)
    }
}
