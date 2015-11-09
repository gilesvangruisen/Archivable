import Foundation
import Curry
import Runes
import Archivable

internal struct TypeMismatchModel {
    let intProp: Int
    let textProp: String

    internal init(intProp: Int, textProp: String) {
        self.intProp = intProp
        self.textProp = textProp
    }
}

extension TypeMismatchModel: Archivable {
    func encode(encoder: Encoder) {
        encoder.encode(self.intProp, forKey: "intProp")
        // This model is bad because we encode a mismatched type for key "textProp"
        // As a result, decode should fail
        encoder.encode(self.intProp, forKey: "textProp")
    }

    static func decode(decoder: Decoder) -> Decoded<TypeMismatchModel> {
        return curry(TypeMismatchModel.init)
            <^> decoder.decode("intProp")
            <*> decoder.decode("textProp")
    }
}
