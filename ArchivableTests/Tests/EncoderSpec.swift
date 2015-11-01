import Quick
import Nimble
import Runes

@testable import Archivable

class EncoderSpec: QuickSpec {

    override func spec() {
        describe("Encoder") {
            describe("encoding an Archivable value") {
                context("when the value is a string") {
                    it("should encode directly on archiver") {
                        let original = "value"
                        let data = original.encodedData()
                        let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                        let value = unarchiver.decodeObjectForKey("") as? NSString

                        expect(value).to(equal(original))
                    }
                }

                context("when the value is a struct") {
                    it("should encode its encoded properties on archiver") {
                        let original = Place(city: "Newport", state: "RI")
                        let data = original.encodedData()
                        let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                        let wrappedCity = unarchiver.decodeObjectForKey("city") as? NSData
                        let cityUnarchiver = NSKeyedUnarchiver(forReadingWithData: wrappedCity!)
                        let city = cityUnarchiver.decodeObjectForKey("") as? NSString

                        expect(city).to(equal(original.city))
                    }
                }

                context("when the value has multiple layers of stored properties") {
                    it("should recursively encode its encoded properties on archiver") {
                        let newport = Place(city: "Newport", state: "RI")
                        let giles = Person(name: "Giles", age: 21, home: newport)
                        let data = giles.encodedData()
                        let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                        let wrappedHome = unarchiver.decodeObjectForKey("home") as? NSData
                        let homeUnarchiver = NSKeyedUnarchiver(forReadingWithData: wrappedHome!)
                        let wrappedCity = homeUnarchiver.decodeObjectForKey("city") as? NSData
                        let cityUnarchiver = NSKeyedUnarchiver(forReadingWithData: wrappedCity!)
                        let city = cityUnarchiver.decodeObjectForKey("") as? NSString

                        expect(city).to(equal(newport.city))
                    }
                }
            }
        }
    }
}