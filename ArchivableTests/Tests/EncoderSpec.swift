import Quick
import Nimble
import Runes

@testable import Archivable

func makeDecoder(data: NSData) -> String -> AnyObject? {
    return NSKeyedUnarchiver(forReadingWithData: data).decodeObjectForKey
}

func decode(data: NSData?, _ key: String?) -> AnyObject? {
    return { $0 -<< key } -<< makeDecoder <^> data
}

func tailDecode(data: NSData?, _ keys: [String]) -> AnyObject? {
    let decoded = decode(data, keys.first)

    if keys.count <= 1 {
        return decoded
    }

    return tailDecode(decoded as? NSData, Array(keys.dropFirst()))
}

class EncoderSpec: QuickSpec {
    override func spec() {
        describe("Encoder") {
            describe("encoding an ArchivableStandardType value") {
                it("should encode directly on archiver successfully") {
                    let original = "some string"
                    let encoder = Encoder().encode(original, forKey: "some key")
                    let value = tailDecode(encoder.encodedData(), ["some key"])

                    expect(value).toNot(beNil())
                    expect(value as? String).to(equal(original))
                }
            }

            describe("encoding an Archivable value") {
                context("when the value is a struct") {

                    it("should encode stored properties on archiver") {
                        let original = Place(city: "Newport", state: "RI")
                        let encoder = Encoder().encode(original, forKey: "root")
                        let city = tailDecode(encoder.encodedData(), ["root", "city"]) as? String

                        expect(city).toNot(beNil())
                        expect(city).to(equal(original.city))
                    }
                }

                context("when the value has multiple layers of stored properties") {
                    it("should recursively encode its encoded properties on archiver") {
                        let originalHome = Place(city: "Newport", state: "RI")
                        let originalPerson = Person(name: "Giles", age: 21, home: originalHome)

                        let encoder = Encoder().encode(originalPerson, forKey: "root")
                        let city = tailDecode(encoder.encodedData(), ["root", "home", "city"]) as? String

                        expect(city).toNot(beNil())
                        expect(city).to(equal(originalPerson.home.city))
                    }
                }
            }
        }
    }
}
