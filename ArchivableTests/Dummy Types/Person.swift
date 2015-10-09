//
//  User.swift
//  StorableValue
//
//  Created by Giles Van Gruisen on 10/1/15.
//  Copyright © 2015 Giles Van Gruisen. All rights reserved.
//

import Archivable
import Foundation

internal struct Person {
    internal init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    internal let name: String
    internal let age: Int
}

extension Person: Equatable {}

func ==(lhs: Person, rhs: Person) -> Bool {
    return lhs.name == rhs.name
        && lhs.age == rhs.age
}

extension Person: Archivable {

    func encode(coder: NSKeyedArchiver) {
        coder.encodeObject(name, forKey: "name")
        coder.encodeInteger(age, forKey: "age")
    }

    static func decode(coder: NSKeyedUnarchiver) -> Person? {
        return self.init(
            name: coder.decodeObjectForKey("name") as! String,
            age: coder.decodeIntegerForKey("age")
        )
    }

}
