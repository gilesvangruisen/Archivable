//
//  StandardTypes.swift
//  Archivable
//
//  Created by Giles Van Gruisen on 10/10/15.
//  Copyright © 2015 Giles Van Gruisen. All rights reserved.
//

import Foundation

extension Int: Archivable {

    public func encode(encoder: Encoder) {
        encoder.encodeDirect { archiver in
            archiver.encodeInteger(self, forKey: "value")
        }
    }

    public static func decode(decoder: Decoder) -> Int? {
        return decoder.decodeDirect { (unarchiver) -> Int? in
            if !unarchiver.containsValueForKey("value") {
                return .None
            } else {
                return unarchiver.decodeIntegerForKey("value")
            }
        }
    }

}

extension String: Archivable {

    public func encode(encoder: Encoder) {
        encoder.encodeDirect { archiver in
            archiver.encodeObject(self, forKey: "value")
        }
    }

    public static func decode(encoder: Decoder) -> DecodedType? {
        return encoder.decodeDirect { unarchiver -> DecodedType? in
            return unarchiver.decodeObjectForKey("value") as? String
        }
    }

}
