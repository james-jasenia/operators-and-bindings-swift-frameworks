# operators-and-bindings-swift-frameworks


# RxSwift
### `BehaviorSubject` vs `BehaviorRelay` - `.values` vs `.value`

A `subject` has a values property of type `AsyncThrowingStream<Element, Error>` and a `relay` has a public value property which is a `!try` of a `subject`s element. This kinda makes sense as `subjects` can be terminate which means that an emission might not be a value. `Relays` cannot terminate so there should always be a value even if it is nil.



## TODO:
[ ] Create `mapMany` methods for `ReactiveSwift` and `Combine` observables. It probably wouldn't hurt to have a `Foundation` `mapMany` method as well.

```
extension ObservableType where Element: Collection {
    public func mapMany<Result>(_ transform: @escaping (Element.Element) throws -> Result) -> Observable<[Result]> {
        return map { collection -> [Result] in
            try collection.map(transform)
        }
    }
}
```

