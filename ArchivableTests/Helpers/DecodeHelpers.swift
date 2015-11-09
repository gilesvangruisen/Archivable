import Foundation
import Runes

func makeDecoder(data: NSData) -> String -> AnyObject? {
    return NSKeyedUnarchiver(forReadingWithData: data).decodeObjectForKey
}

func decode(data: NSData?, _ key: String?) -> AnyObject? {
    return { $0 -<< key } -<< makeDecoder <^> data
}

func tailDecode(data: NSData?, _ keys: [String]) -> AnyObject? {
    let decoded = decode(data, keys.first)

    if keys.count <= 1 {
        return decoded
    }

    return tailDecode(decoded as? NSData, Array(keys.dropFirst()))
}
