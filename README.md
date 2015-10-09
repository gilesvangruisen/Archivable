# Archivable
Archivable lets you simply encode and decode value types in Swift, allowing them to easily be archived locally with `NSUserDefaults` or another similar cache.

## How does it work?
`Archivable` is a protocol that defines two methods, `encode` and `decode`, for encoding `self` to `NSData` and failably decoding `NSData` back to `Self`, respectively.

## Example

Define a custom type
```Swift
struct Person {
  let name: String
  let age: Int
}
```

Extend your type to conform to `Archivable`
```Swift
extension Person: Archivable {
  func encode(coder: NSKeyedArchiver) {
      coder.encodeObject(name, forKey: "name")
      coder.encodeInteger(age, forKey: "age")
  }

  static func decode(coder: NSKeyedUnarchiver) -> Person? {
      return Person(
        name: coder.decodeObjectForKey("name") as! String,
        age: coder.decodeIntegerForKey("age")
      )
  }
}
```

Encode and save to `NSUserDefaults`, then decode again.
```Swift
// Create & encode Person
let giles = Person(name: "Giles", age: Int)
NSUserDefaults.standardUserDefaults().setValue(giles, forKey: "current_user")

// Decode Person
let currentUserData = NSUserDefaults.standardUserDefaults().valueForKey("current_user")
let currentUser = Person.decodedValue(currentUserData) // returns Person?
```
