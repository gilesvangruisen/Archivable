//
//  Person.swift
//  StorableValue
//
//  Created by Giles Van Gruisen on 10/1/15.
//  Copyright © 2015 Giles Van Gruisen. All rights reserved.
//

import Foundation
import Archivable

internal struct Person {
    internal init(name: String, age: Int, home: Place) {
        self.name = name
        self.age = age
        self.home = home
    }
    let name: String
    let age: Int
    let home: Place
}

extension Person: Equatable {}

func ==(lhs: Person, rhs: Person) -> Bool {
    return lhs.name == rhs.name
        && lhs.age  == rhs.age
        && lhs.home == rhs.home
}

extension Person: Archivable {

    func encode(coder: NSKeyedArchiver) {
        coder.encodeObject(name, forKey: "name")
        coder.encodeInteger(age, forKey: "age")
        coder.encodeValue(home, forKey: "home")
    }

    static func decode(coder: NSKeyedUnarchiver) -> Person? {
        return self.init(
            name: coder.decodeObjectForKey("name") as! String,
            age: coder.decodeIntegerForKey("age"),
            home: coder.decodeValue(forKey: "home")!
        )
    }

}
