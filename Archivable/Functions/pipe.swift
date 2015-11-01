infix operator |> {
    associativity left
    precedence 130
}

infix operator <| {
    associativity right
    precedence 130
}

func <|<A, B>(f: A -> B, a: A) -> B {
    return f(a)
}

func |><A, B>(a: A, f: A -> B) -> B {
    return f(a)
}
