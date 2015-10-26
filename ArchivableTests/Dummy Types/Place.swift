//
//  Place.swift
//  Archivable
//
//  Created by Giles Van Gruisen on 10/10/15.
//  Copyright © 2015 Giles Van Gruisen. All rights reserved.
//

import Foundation
import Curry
import Runes
import Archivable

internal struct Place {
    internal let city: String
    internal let state: String

    internal init(city: String, state: String) {
        self.city = city
        self.state = state
    }
}

extension Place: Equatable {}

func ==(lhs: Place, rhs: Place) -> Bool {
    return lhs.city == rhs.city
        && lhs.state == rhs.state
}

extension Place: Archivable {

    func encode(encoder: Encoder) {
        encoder.encode(city, forKey: "city")
        encoder.encode(state, forKey: "state")
    }

    static func decode(decoder: Decoder) -> Place? {
        return curry(Place.init)
            <^> decoder.decode("city")
            <*> decoder.decode("state")
    }

}
