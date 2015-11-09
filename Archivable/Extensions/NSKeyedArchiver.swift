import Foundation

public extension NSKeyedArchiver {

    public func encodeValue(value: Archivable?, forKey key: String) -> Void {
        self.encodeObject(value?.encodedData(), forKey: key)
    }

    public func encodeValue(value: Archivable?) -> Void {
        self.encodeObject(value?.encodedData())
    }

    func encodeStandardType(value: ArchivableStandardType?, forKey key: String) -> Void {
        value?.encode(toArchiver: self, forKey: key)
    }

}

public extension NSKeyedUnarchiver {

    public func decodeValue<T: Archivable>(forKey key: String) -> Decoded<T> {
        guard let object = self.decodeObjectForKey(key) else {
            return .Failure("Missing Key: '\(key)'")
        }

        guard let data = object as? NSData else {
            return .Failure("Type Mismatch: expected '\(T.self)' for key '\(key)'")
        }

        return T.decodedValue(data)
    }

    public func decodeValue<T: Archivable>() -> Decoded<T> {
        guard let data = self.decodeObject() as? NSData else {
            return Decoded.Failure("Empty Data")
        }

        return T.decodedValue(data)
    }

    func decodeStandardType<T: ArchivableStandardType>(forKey key: String) -> Decoded<T> {
        if !self.containsValueForKey(key) {
            return .Failure("Missing Key: '\(key)'")
        }

        guard let value = T.decode(fromUnarchiver: self, forKey: key) else {
            return .Failure("Type Mismatch: expected '\(T.self)' for key '\(key)'")
        }

        return .fromOptional(value)
    }

}
