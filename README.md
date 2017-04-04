# RxProperty

A get-only `Variable` that is equivalent to [ReactiveSwift](https://github.com/ReactiveCocoa/ReactiveSwift)'s [`Property`](https://github.com/ReactiveCocoa/ReactiveSwift/blob/1.1.0/Sources/Property.swift#L455).

This class is highly useful to encapsulate `Variable` inside ViewModel so that other classes cannot reach its setter (unbindable) and make state management safer.

In short:

```swift
public final class 💩ViewModel<T> {
    // 💩 This is almost the same as `var state: T`.
    // DON'T EXPOSE "VAR"IABLE!
    public let state = Variable<T>(...)

    // 💩 Exposing `Observable` is NOT a good solution either
    // because type doesn't tell us that it contains at least one value
    // and we cannot even "extract" it.
    public var stateObservable: Observable<T> {
        return state.asObservable()
    }
}
```

```swift
public final class 👍ViewModel<T> {
    // 👍 Hide "var"iable.
    private let _state = Variable<T>(...)

    // 👍 `Property` is a better type than `Observable`.
    public let state: Property<T>
    
    public init() {
        self.state = Property(_state)
    }
}
```

## Disclaimer

Since this library should rather go to RxSwift-core, **there is no plan to release as a 3rd-party microframework** for CocoaPods/Carthage/SwiftPackageManager. 

If you like it, please upvote [ReactiveX/RxSwift#1118](https://github.com/ReactiveX/RxSwift/pull/1118) and join the discussion.
Current recommended way is to directly use the source code to your project.

## License

[MIT](LICENSE)
