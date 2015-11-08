import Foundation

public struct Encoder {

    internal let data: NSMutableData
    internal let archiver: NSKeyedArchiver

    public init() {
        data = NSMutableData()
        archiver = NSKeyedArchiver(forWritingWithMutableData: data)
    }

    public func encodedData() -> NSData {
        archiver.finishEncoding()
        return NSData(data: data)
    }

    public func encode<Value: Archivable>(value: Value?, forKey key: String) -> Encoder {
        if let value = value {
            archiver.encodeObject(value.encodedData(), forKey: key)
        }

        return self
    }

    public func encode<Value: ArchivableStandardType>(value: Value?, forKey key: String) -> Encoder {
        value?.encode(toArchiver: archiver, forKey: key)

        return self
    }

}
