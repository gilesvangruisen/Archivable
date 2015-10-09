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

        describe("Archivable") {

            describe("encoding a simple value") {

                let person = Person(name: "giles", age: 21) // dummy
                let data = person.encodedData() // encode so we can decode
                let restoredPerson = Person.decodedValue(data)

                describe("restoredPerson") {
                    it("should not be nil") {
                        expect(restoredPerson).toNot(beNil())
                    }

                    it("should hold onto the original value") {
                        expect(restoredPerson?.name).to(equal("giles"))
                        expect(restoredPerson?.age).to(equal(21))
                    }
                }

            }
        }
    }
    
}
