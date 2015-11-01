import Foundation

public enum Decoded<T> {
    case Success(T)
    case Failure(String)

    public var value: T? {
        switch self {
        case let .Success(value): return value
        default: return .None
        }
    }

    public var error: String? {
        switch self {
        case let .Failure(reason): return reason
        default: return .None
        }
    }
}

extension Decoded {
    public static func fromOptional<T>(x: T?) -> Decoded<T> {
        switch x {
        case let .Some(value): return .Success(value)
        default: return .Failure("empty optional")
        }
    }
}

extension Decoded {
    public func map<U>(f: T -> U) -> Decoded<U> {
        switch self {
        case let .Success(value): return .Success(f(value))
        case let .Failure(error): return .Failure(error)
        }
    }
}

extension Decoded {
    public func apply<U>(f: Decoded<T -> U>) -> Decoded<U> {
        switch f {
        case let .Success(function): return self.map(function)
        case let .Failure(error): return .Failure(error)
        }
    }
}
