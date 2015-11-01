import Foundation

public extension NSKeyedArchiver {

    func encodeValue<Value: Archivable>(value: Value?, forKey key: String) -> Void {
        self.encodeObject(value?.encodedData(), forKey: key)
    }

    func encodeValue<Value: Archivable>(value: Value?) -> Void {
        self.encodeObject(value?.encodedData())
    }

}

public extension NSKeyedUnarchiver {

    func decodeValue<Value: Archivable>(forKey key: String) -> Decoded<Value> {
        guard let data = self.decodeObjectForKey(key) as? NSData else {
            return Decoded.Failure("missing key")
        }

        return Value.decodedValue(data)
    }

    func decodeValue<Value: Archivable>() -> Decoded<Value> {
        guard let data = self.decodeObject() as? NSData else {
            return Decoded.Failure("missing key")
        }

        return Value.decodedValue(data)
    }
}
