# operators-and-bindings-swift-frameworks


# RxSwift
### `BehaviorSubject` vs `BehaviorRelay` - `.values` vs `.value`

A `subject` has a values property of type `AsyncThrowingStream<Element, Error>` and a `relay` has a public value property which is a `!try` of a `subject`s element. This kinda makes sense as `subjects` can be terminate which means that an emission might not be a value. `Relays` cannot terminate so there should always be a value even if it is nil.


# Combine
### `Deferred` and `Future`
You need wrap `Future` in a `Deferred` block so that the `Future` will only be created upon subscription, otherwise, the `Future` will be created and excute it's work (common use case is a network request) before anything is observing it. This setup will behave the same way a `Single` does in `RxSwift.

## TODO:
Create `mapMany` methods for `ReactiveSwift` and `Combine` observables. It probably wouldn't hurt to have a `Foundation` `mapMany` method as well.

```
extension ObservableType where Element: Collection {
    public func mapMany<Result>(_ transform: @escaping (Element.Element) throws -> Result) -> Observable<[Result]> {
        return map { collection -> [Result] in
            try collection.map(transform)
        }
    }
}
```

