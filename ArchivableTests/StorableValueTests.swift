//
//  StorableValueTests.swift
//  StorableValueTests
//
//  Created by Giles Van Gruisen on 10/1/15.
//  Copyright © 2015 Giles Van Gruisen. All rights reserved.
//

import Quick
import Nimble

@testable import Archivable

class StorableValueTests: QuickSpec {
    
    override func spec() {

        describe("Archivable type") {

            let newport = Place(city: "Newport", state: "RI")
            let person = Person(name: "giles", age: 21, home: newport)
            let data = person.encodedData()
            let restoredPerson = Person.decodedValue(data)

            context("when decoded") {

                it("should not be nil") {
                    expect(restoredPerson).toNot(beNil())
                }

                it("should be equivalent to the original value") {
                    expect(restoredPerson).to(equal(person))
                }

                it("should retain stored Archivable values") {
                    expect(restoredPerson!.home).to(equal(person.home))
                }

            }
        }
    }
    
}
