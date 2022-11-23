# operators-and-bindings-swift-frameworks

# RxSwift
### `BehaviorSubject` vs `BehaviorRelay`
A `subject` has a values property of type `AsyncThrowingStream<Element, Error>` and a `relay` has a public value property which is a `!try` of a `subject`s element. This kinda makes sense as `subjects` can be terminate which means that an emission might not be a value. `Relays` cannot terminate so there should always be a value even if it is nil.
