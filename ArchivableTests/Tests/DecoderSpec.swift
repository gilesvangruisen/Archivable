import Quick
import Nimble
import Runes

@testable import Archivable

class DecoderSpec: QuickSpec {

    override func spec() {
        describe("Decoder") {
            it("should decode an ArchivableStandardType value") {
                let original = "Some string"
                let encodedData = Encoder().encode(original, forKey: "root").encodedData()
                let decoder = Decoder(data: encodedData)

                let result: Decoded<String> = decoder.decode("root")

                expect(result.error).to(beNil())
                expect(result.value).toNot(beNil())
                expect(result.value).to(equal(original))
            }

            it("should decode an Archivable value") {
                let original = Place(city: "Newport", state: "RI")
                let encodedData = Encoder().encode(original, forKey: "root").encodedData()
                let decoder = Decoder(data: encodedData)

                let result: Decoded<Place> = decoder.decode("root")

                expect(result.error).to(beNil())
                expect(result.value).toNot(beNil())
                expect(result.value).to(equal(original))
            }

            it("should flatly decode stored Archivable values") {
                let originalPlace = Place(city: "Newport", state: "RI")
                let originalPerson = Person(name: "Giles", age: 21, home: originalPlace)
                let encodedData = Encoder().encode(originalPerson, forKey: "root").encodedData()
                let decoder = Decoder(data: encodedData)

                let result: Decoded<Person> = decoder.decode("root")

                expect(result.error).to(beNil())
                expect(result.value).toNot(beNil())
                expect(result.value).to(equal(originalPerson))
            }

            context("decoding an Archivable value with an incomplete encode") {
                it("should fail with a Type Mismatch error") {
                    let original = MissingKeyModel(intProp: 0, textProp: "text")
                    let encodedData = Encoder().encode(original, forKey: "root").encodedData()
                    let decoder = Decoder(data: encodedData)

                    let result: Decoded<MissingKeyModel> = decoder.decode("root")

                    expect(result.error).toNot(beNil())
                    expect(result.error).to(equal("Missing Key: 'textProp'"))
                    expect(result.value).to(beNil())
                }
            }

            context("decoding an Archivable value with a type-incorrect encode") {
                it("should fail with a Type Mismatch error") {
                    let original = MissingKeyModel(intProp: 0, textProp: "text")
                    let encodedData = Encoder().encode(original, forKey: "root").encodedData()
                    let decoder = Decoder(data: encodedData)

                    let result: Decoded<MissingKeyModel> = decoder.decode("root")

                    expect(result.error).toNot(beNil())
                    expect(result.error).to(equal("Type Mismatch: expected 'String' for key 'textProp'"))
                    expect(result.value).to(beNil())
                }
            }
        }
    }
}
