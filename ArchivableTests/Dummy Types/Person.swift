//
//  Person.swift
//  StorableValue
//
//  Created by Giles Van Gruisen on 10/1/15.
//  Copyright © 2015 Giles Van Gruisen. All rights reserved.
//

import Foundation
import Curry
import Runes
import Archivable

internal struct Person {
    let name: String
    let age: Int
    let home: Place

    internal init(name: String, age: Int, home: Place) {
        self.name = name
        self.age = age
        self.home = home
    }
}

extension Person: Equatable {}

func == (lhs: Person, rhs: Person) -> Bool {
    return lhs.name == rhs.name
        && lhs.age  == rhs.age
        && lhs.home == rhs.home
}

extension Person: Archivable {

    func encode(encoder: Encoder) {
        encoder.encode(name, forKey: "name")
        encoder.encode(age, forKey: "age")
        encoder.encode(home, forKey: "home")
    }

    static func decode(decoder: Decoder) -> Person? {
        return curry(Person.init)
            <^> decoder.decode("name")
            <*> decoder.decode("age")
            <*> decoder.decode("home")
    }

}
