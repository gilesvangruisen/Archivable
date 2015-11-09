import Foundation

public struct Decoder {

    let data: NSData
    let unarchiver: NSKeyedUnarchiver

    public init(data: NSData) {
        self.data = data
        unarchiver = NSKeyedUnarchiver(forReadingWithData: self.data)
    }

    public func decode<T: Archivable>(key: String) -> Decoded<T> {
        return unarchiver.decodeValue(forKey: key)
    }

    public func decode<T: ArchivableStandardType>(key: String) -> Decoded<T> {
        return unarchiver.decodeStandardType(forKey: key)
    }
}
