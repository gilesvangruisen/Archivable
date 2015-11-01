import Foundation

extension String: Archivable {

    public func encode(var encoder: Encoder) {
        encoder.encodeDirect { $0.encodeObject(self, forKey: "") }
    }

    public static func decode(decoder: Decoder) -> Decoded<String> {
        return decoder.decodeDirect { $0.decodeObjectForKey("") as? String }
    }

}

extension Int: Archivable {

    public func encode(var encoder: Encoder) {
        encoder.encodeDirect { $0.encodeInteger(self, forKey: "") }
    }

    public static func decode(decoder: Decoder) -> Decoded<Int> {
        return decoder.decodeDirect { $0.decodeIntegerForKey("") }
    }
    
}
