//
//  Place.swift
//  Archivable
//
//  Created by Giles Van Gruisen on 10/10/15.
//  Copyright © 2015 Giles Van Gruisen. All rights reserved.
//

import Foundation
import Archivable

internal struct Place {
    internal init(city: String, state: String) {
        self.city = city
        self.state = state
    }
    internal let city: String
    internal let state: String
}

extension Place: Equatable {}

func ==(lhs: Place, rhs: Place) -> Bool {
    return lhs.city == rhs.city
        && lhs.state == rhs.state
}

extension Place: Archivable {

    func encode(coder: NSKeyedArchiver) {
        coder.encodeObject(city, forKey: "city")
        coder.encodeObject(state, forKey: "state")
    }

    static func decode(coder: NSKeyedUnarchiver) -> Place? {
        return self.init(
            city: coder.decodeObjectForKey("city") as! String,
            state: coder.decodeObjectForKey("state") as! String
        )
    }
    
}
