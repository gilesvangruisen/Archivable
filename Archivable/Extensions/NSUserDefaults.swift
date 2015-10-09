//
//  NSUserDefaults.swift
//  Archivable
//
//  Created by Giles Van Gruisen on 10/9/15.
//  Copyright © 2015 Giles Van Gruisen. All rights reserved.
//

import Foundation

public extension NSUserDefaults {

    func setValue<Value: Archivable>(value: Value?, forKey key: String) {
        if let value = value {
            setObject(value.encodedData(), forKey: key)
        }
    }

    func valueForKey<Value: Archivable>(key: String) -> Value? {
        guard let data = objectForKey(key) as? NSData else {
            return .None
        }

        return Value.decodedValue(data)
    }

}
