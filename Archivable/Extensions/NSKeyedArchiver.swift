import Foundation

public extension NSKeyedArchiver {

    func encodeValue(value: Archivable?, forKey key: String) -> Void {
        self.encodeObject(value?.encodedData(), forKey: key)
    }

    func encodeValue(value: Archivable?) -> Void {
        self.encodeObject(value?.encodedData())
    }

    func encodeStandardType(value: ArchivableStandardType?, forKey key: String) -> Void {
        value?.encode(toArchiver: self, forKey: key)
    }

}

public extension NSKeyedUnarchiver {

    func decodeValue<T: Archivable>(forKey key: String) -> Decoded<T> {
        guard let data = self.decodeObjectForKey(key) as? NSData else {
            return Decoded.Failure("missing key")
        }

        return T.decodedValue(data)
    }

    func decodeValue<T: Archivable>() -> Decoded<T> {
        guard let data = self.decodeObject() as? NSData else {
            return Decoded.Failure("missing key")
        }

        return T.decodedValue(data)
    }

    func decodeStandardType<T: ArchivableStandardType>(forKey key: String) -> Decoded<T> {
        guard let value = T.decode(fromUnarchiver: self, forKey: key) as T? else {
            return Decoded.Failure("missing key")
        }

        return Decoded<T>.fromOptional(value)
    }

}
