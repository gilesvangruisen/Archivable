//
//  NSKeyedArchiver.swift
//  StorableValue
//
//  Created by Giles Van Gruisen on 10/3/15.
//  Copyright © 2015 Giles Van Gruisen. All rights reserved.
//

import Foundation

public extension NSKeyedArchiver {

    func encodeValue<Value: Archivable>(value: Value?, forKey key: String) -> Void {
        self.encodeObject(value?.encodedData(), forKey: key)
    }

    func encodeValue<Value: Archivable>(value: Value?) -> Void {
        self.encodeObject(value?.encodedData())
    }

}

public extension NSKeyedUnarchiver {

    func decodeValue<Value: Archivable>(forKey key: String) -> Value? {
        guard let data = self.decodeObjectForKey(key) as? NSData else {
            return .None
        }

        return Value.decodedValue(data)
    }

    func decodeValue<Value: Archivable>() -> Value? {
        guard let data = self.decodeObject() as? NSData else {
            return .None
        }

        return Value.decodedValue(data)
    }
}
