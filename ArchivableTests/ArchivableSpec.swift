import Quick
import Nimble

@testable import Archivable

class ArchivableSpec: QuickSpec {
    
    override func spec() {

        describe("Archivable type") {

            let newport = Place(city: "Newport", state: "RI")
            let person = Person(name: "giles", age: 21, home: newport)
            let data = person.encodedData()
            let decodedPerson = Person.decodedValue(data)

            print(decodedPerson.error)
            print(decodedPerson.value)

            context("when decoded") {

                it("should not error") {
                    expect(decodedPerson.error).to(beNil())
                }

                it("should not be nil") {
                    expect(decodedPerson.value).toNot(beNil())
                }

                it("should be equivalent to the original value") {
                    expect(decodedPerson.value).to(equal(.Some(person)))
                }

                it("should retain stored Archivable values") {
                    expect(decodedPerson.value?.home).to(equal(.Some(person.home)))
                }

            }
        }
    }
    
}
