import Foundation
import Curry
import Runes
import Archivable

internal struct MissingKeyModel {
    let intProp: Int
    let textProp: String

    internal init(intProp: Int, textProp: String) {
        self.intProp = intProp
        self.textProp = textProp
    }
}

extension MissingKeyModel: Archivable {
    func encode(encoder: Encoder) {
        encoder.encode(self.intProp, forKey: "intProp")
        // This model is bad because we fail to fully implement `encode`
        // As a result, decode should fail
    }

    static func decode(decoder: Decoder) -> Decoded<MissingKeyModel> {
        return curry(MissingKeyModel.init)
            <^> decoder.decode("intProp")
            <*> decoder.decode("textProp")
    }
}
