import Foundation

public protocol Archivable {

    // Tells the Encoder how to encode Self
    func encode(encoder: Encoder)

    // Tells the Decoder how to decode Self
    static func decode(decoder: Decoder) -> Decoded<Self>

}

public extension Archivable {

    internal func _encode(encoder: Encoder) -> Encoder {
        self.encode(encoder)
        return encoder
    }

    public func encodedData() -> NSData {
        return _encode(Encoder()).encodedData()
    }

    public static func decodedValue(data: NSData) -> Decoded<Self> {
        return self.decode(Decoder(data: data))
    }
}
