import Foundation

public extension NSUserDefaults {

    func setValue<T: Archivable>(value: T?, forKey key: String) {
        if let value = value {
            setObject(value.encodedData(), forKey: key)
        }
    }

    func valueForKey<T: Archivable>(key: String) -> Decoded<T> {
        guard let object = objectForKey(key) else {
            return .Failure("Missing Key: '\(key)'")
        }

        guard let data = object as? NSData else {
            return .Failure("Type Mismatch: expected '\(T.self)' for key '\(key)'")
        }

        return T.decodedValue(data)
    }

}
