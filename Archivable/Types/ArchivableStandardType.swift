import Foundation

public protocol ArchivableStandardType {

    // Encodes `self` directly on `archiver` for given `key`
    func encode(toArchiver archiver: NSKeyedArchiver, forKey key: String) -> Void

    // Attemps to decode value for `key` on `unarchiver` into optional `Self?`
    static func decode(fromUnarchiver unarchiver: NSKeyedUnarchiver, forKey key: String) -> Self?

}


