//
//  Archivable.swift
//  StorableValue
//
//  Created by Giles Van Gruisen on 10/3/15.
//  Copyright © 2015 Giles Van Gruisen. All rights reserved.
//

import Foundation

public protocol Archivable {

    // Tells the Encoder how to encode Self
    func encode(coder: NSKeyedArchiver)

    // Tells the Decoder how to decode Self
    static func decode(coder: NSKeyedUnarchiver) -> Self?

}

public extension Archivable {

    // Archive to NSData
    func encodedData() -> NSData {
        let encoder = Encoder()
        encoder.encode(self)
        return encoder.encodedData()
    }

    static func decodedValue(data: NSData) -> Self? {
        let decoder = Decoder(data: data)
        return decoder.decode()
    }

}