import Foundation

public extension NSUserDefaults {

    func setValue<Value: Archivable>(value: Value?, forKey key: String) {
        if let value = value {
            setObject(value.encodedData(), forKey: key)
        }
    }

    func valueForKey<Value: Archivable>(key: String) -> Decoded<Value> {
        guard let data = objectForKey(key) as? NSData else {
            return Decoded.Failure("missing key")
        }

        return Value.decodedValue(data)
    }

}
