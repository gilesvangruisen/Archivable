# Archivable
Archivable is a library for functionally encoding and decoding Swift value
types, allowing them to stored locally with `NSUserDefaults` or another `NSData`
cache. The library was heavily inspired by the functional JSON parsing library,
[Argo](http://github.com/thoughtbot/argo).

## How do I use it?
`Archivable` is a protocol that defines two methods, `encode(encoder: Encoder)`
and `decode(decoder: Decoder) -> Decoded<Self>`. The first allows custom types
to be encoded and stored as serialized `NSData`, while the second allows those
types to then be failably decoded and initialized from `NSData`.

## Example

In the following example, we define a simple model, `Person`, which contains two
stored properties: `name` of type `String`, and `age` of type `Int`. We then
extend our `Person` model to conform to `Archivable`, providing the two method
implementations necessary for encoding and decoding to/from `NSData`.

```Swift
import Runes
import Archivable

struct Person {
  let name: String
  let age: Int
}

extension Person: Archivable {
  func encode(encoder: Encoder) {
    encoder.encode(name, forKey: "name")
    encoder.encode(age, forKey: "age")
  }

  static func decode(coder: NSKeyedUnarchiver) -> Decoded<Person> {
    return curry(Person.init)
      <^> decoder.decode("name")
      <*> decoder.decode("age")
  }
}
```

Now, you can easily encode and store any instance of `Person`, just as you would
with a `NSCoding` compliant model, but you get all the inherent benefits of
immutable value types. :tada:

For example, we can save a `Person` to `NSUserDefaults`, then decode again
later as needed:

```Swift
let defaults = NSUserDefaults.standardUserDefaults()
let giles = Person(name: "Giles", age: 21)

// Encode
defaults.setValue(giles, forKey: "dummy")

// Decode
let decodedGiles: Decoded<Person> = defaults.valueForKey("dummy")

// Confirm
if let dummy = decodedGiles.value {
    print(dummy.name) // prints "Giles"
}
```

