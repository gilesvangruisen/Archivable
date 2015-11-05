import Foundation
import Curry
import Runes
import Archivable

internal struct Place {
    let city: String
    let state: String

    internal init(city: String, state: String) {
        self.city = city
        self.state = state
    }
}

extension Place: Equatable {}

func ==(lhs: Place, rhs: Place) -> Bool {
    return lhs.city == rhs.city
        && lhs.state == rhs.state
}

extension Place: Archivable {

    func encode(encoder: Encoder) {
        encoder.encode(city, forKey: "city")
        encoder.encode(state, forKey: "state")
    }

    static func decode(decoder: Decoder) -> Decoded<Place> {
        return curry(Place.init)
            <^> decoder.decode("city")
            <*> decoder.decode("state")
    }

}
