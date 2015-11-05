import Quick
import Nimble
import Runes

@testable import Archivable

func valueDecoder(data: NSData) -> String -> AnyObject? {
    return NSKeyedUnarchiver.decodeObjectForKey <| NSKeyedUnarchiver.init <| data
}

func decode(data: NSData?)(_ key: String?) -> AnyObject? {
    return { $0 -<< key } -<< valueDecoder <^> data
}

func tailDecode(data: NSData?, _ keys: [String]) -> AnyObject? {
    let decoded = decode(data)(keys.first)

    if keys.count <= 1 {
        return decoded
    }

    return tailDecode(decoded as? NSData, Array(keys.dropFirst()))
}

class EncoderSpec: QuickSpec {

    override func spec() {
        describe("Encoder") {
            describe("encoding an Archivable value") {
                context("when the value is a string") {
                    it("should encode directly on archiver") {
                        let original = "value"
                        let value = tailDecode(original.encodedData(), [""]) as? String

                        expect(value).toNot(beNil())
                        expect(value).to(equal(original))
                    }
                }

                context("when the value is a struct") {

                    it("should encode stored properties on archiver") {
                        let original = Place(city: "Newport", state: "RI")
                        let city = tailDecode(original.encodedData(), ["city", ""]) as? String

                        expect(city).toNot(beNil())
                        expect(city).to(equal(original.city))
                    }
                }

                context("when the value has multiple layers of stored properties") {
                    it("should recursively encode its encoded properties on archiver") {
                        let originalHome = Place(city: "Newport", state: "RI")
                        let originalPerson = Person(name: "Giles", age: 21, home: originalHome)
                        let city = tailDecode(originalPerson.encodedData(), ["home", "city", ""]) as? String

                        expect(city).toNot(beNil())
                        expect(city).to(equal(originalPerson.home.city))
                    }
                }
            }
        }
    }
}
