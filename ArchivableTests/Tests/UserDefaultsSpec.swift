import Quick
import Nimble

@testable import Archivable

class UserDefaultsSpec: QuickSpec {
    override func spec() {
        describe("NSUserDefaults") {
            let defaults = NSUserDefaults.standardUserDefaults()

            describe("setting an Archivable value") {
                it("getting the value back should succeed") {
                    let original = Place(city: "NYC", state: "NY")
                    defaults.setValue(original, forKey: "currentCity")
                    let decoded: Decoded<Place> = defaults.valueForKey("currentCity")

                    expect(decoded.error).to(beNil())
                    expect(decoded.value).toNot(beNil())
                    expect(decoded.value).to(equal(original))
                }
            }

            describe("getting a non-existent value") {
                it("should fail with Missing Key error") {
                    let decoded: Decoded<Place> = defaults.valueForKey("nonexistent")

                    expect(decoded.value).to(beNil())
                    expect(decoded.error).toNot(beNil())
                    expect(decoded.error).to(equal("Missing Key: 'nonexistent'"))
                }
            }

            context("getting a value of a mismatched type") {
                it("should fail with a Mismatched Type error") {
                    let value = "some string"
                    defaults.setValue(value, forKey: "string")
                    let decoded: Decoded<Person> = defaults.valueForKey("string")

                    expect(decoded.value).to(beNil())
                    expect(decoded.error).toNot(beNil())
                    expect(decoded.error).to(equal("Type Mismatch: expected 'Person' for key 'string'"))
                }
            }
        }
    }
}
