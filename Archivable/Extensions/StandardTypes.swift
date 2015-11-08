import Foundation

extension String: ArchivableStandardType {
    public func encode(toArchiver archiver: NSKeyedArchiver, forKey key: String) -> Void {
        archiver.encodeObject(self, forKey: key)
    }

    public static func decode(fromUnarchiver unarchiver: NSKeyedUnarchiver, forKey key: String) -> String? {
        return unarchiver.decodeObjectForKey(key) as? String
    }
}

extension Int: ArchivableStandardType {
    public func encode(toArchiver archiver: NSKeyedArchiver, forKey key: String) {
        archiver.encodeInteger(self, forKey: key)
    }

    public static func decode(fromUnarchiver unarchiver: NSKeyedUnarchiver, forKey key: String) -> Int? {
        return unarchiver.decodeIntegerForKey(key)
    }
}
