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

    public func encode(value: Archivable?, forKey key: String) -> Encoder {
        archiver.encodeObject(value?.encodedData(), forKey: key)

        return self
    }

    public func encode(value: ArchivableStandardType?, forKey key: String) -> Encoder {
        value?.encode(toArchiver: archiver, forKey: key)

        return self
    }

}
