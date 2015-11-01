import Runes

public func <*><T, U>(f: Decoded<T -> U>, x: Decoded<T>) -> Decoded<U> {
    return x.apply(f)
}
