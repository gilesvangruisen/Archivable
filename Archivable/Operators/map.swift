import Runes

public func <^><T, U>(f: T -> U, x: Decoded<T>) -> Decoded<U> {
    return x.map(f)
}
