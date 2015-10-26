//
//  Archivable.swift
//  StorableValue
//
//  Created by Giles Van Gruisen on 10/3/15.
//  Copyright © 2015 Giles Van Gruisen. All rights reserved.
//

import Foundation

public protocol Archivable {

    typealias DecodedType

    // Tells the Encoder how to encode Self
    func encode(coder: Encoder)

    // Tells the Decoder how to decode Self
    static func decode(coder: Decoder) -> Self?

}

public extension Archivable {

    // Archive to NSData
    func encodedData() -> NSData {
        let encoder = Encoder()
        self.encode(encoder)
        return encoder.encodedData()
    }

    static func decodedValue(data: NSData) -> Self? {
        let decoder = Decoder(data: data)
        return self.decode(decoder)
    }

}