//
//  StandardTypes.swift
//  StorableValue
//
//  Created by Giles Van Gruisen on 10/3/15.
//  Copyright © 2015 Giles Van Gruisen. All rights reserved.
//

import Foundation

//extension String: Archivable {
//
//    public static func encoder(archiver: NSKeyedArchiver)(value: String, forKey key: String) {
//        return archiver.encodeObject(value, forKey: key)
//    }
//
//    public static func decoder(unarchiver: NSKeyedUnarchiver)(key: String) -> String? {
//        return unarchiver.decodeObjectForKey(key) as? String
//    }
//}
//
//extension Int: Archivable {
//
//    public static func encoder() -> NSKeyedArchiver -> (Int, forKey: String) -> Void {
//
//        return NSKeyedArchiver.encodeInteger
//    }
//
//    public static func decoder() -> NSKeyedUnarchiver -> (String) -> Int? {
//        return NSKeyedUnarchiver.decodeIntegerForKey as NSKeyedUnarchiver -> (String) -> Int?
//    }
//}
//
//extension Array where Element: Archivable {
//
//    public static func encoder(archiver: NSKeyedArchiver)(value: [String], forKey key: String) {
//        let archived = NSKeyedArchiver.archivedDataWithRootObject(value)
//
//        return archiver.encodeObject(archived, forKey: key)
//    }
//
//}