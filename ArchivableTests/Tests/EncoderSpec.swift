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
            it("should encode an ArchivableStandardType value") {
                let original = "some string"
                let encoder = Encoder().encode(original, forKey: "some key")
                let value = decode(encoder.encodedData(), "some key")

                expect(value).toNot(beNil())
                expect(value as? String).to(equal(original))
            }

            it("should encode an Archivable value") {
                let original = Place(city: "Newport", state: "RI")
                let encoder = Encoder().encode(original, forKey: "root")
                let city = tailDecode(encoder.encodedData(), ["root", "city"]) as? String

                expect(city).toNot(beNil())
                expect(city).to(equal(original.city))
            }

            it("should recursively encode an Archivable value with a stored Archivable property") {
                let originalHome = Place(city: "Newport", state: "RI")
                let originalPerson = Person(name: "Giles", age: 21, home: originalHome)

                let encoder = Encoder().encode(originalPerson, forKey: "root")
                let city = tailDecode(encoder.encodedData(), ["root", "home", "city"]) as? String
                expect(city).toNot(beNil())
                expect(city).to(equal(originalPerson.home.city))
            }


            describe("data returned from encodedData()") {
                it("should match manually encoded data") {
                    let place = Place(city: "Boston", state: "MA")

                    let autoEncoder = Encoder().encode(place, forKey: "root")
                    let manualEncoder = Encoder().encode(place, forKey: "root")

                    let autoData = autoEncoder.encodedData()
                    manualEncoder.archiver.finishEncoding()
                    let manualData = NSData(data: manualEncoder.data)

                    expect(manualData).to(equal(autoData))
                }
            }

        }
    }
}
