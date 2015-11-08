import Foundation

public struct Decoder {

    let data: NSData
    let unarchiver: NSKeyedUnarchiver

    public init(data: NSData) {
        self.data = data
        unarchiver = NSKeyedUnarchiver(forReadingWithData: self.data)
    }

    public func decode<T: Archivable>(key: String) -> Decoded<T> {
        guard let data = unarchiver.decodeObjectForKey(key) as? NSData else {
            return Decoded.Failure("missing key")
        }

        return T.decodedValue(data)
    }

    public func decode<T: ArchivableStandardType>(key: String) -> Decoded<T> {
        let value: T? = T.decode(fromUnarchiver: unarchiver, forKey: key)
        return Decoded<T>.fromOptional(value)
    }

    internal func decodeDirect<T: Archivable>(decode: NSKeyedUnarchiver -> T?) -> Decoded<T> {
        return Decoded<T>.fromOptional(decode(unarchiver))
    }
}
