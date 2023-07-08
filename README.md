# WindowReader

Access the current `UIWindow ` or `NSWindow` from SwiftUI

## Usage

### SwiftUI Lifecycle

Read the current `UIWindow` with `WindowReader`

```swift
@main
struct MyView: View {
    var body: some Scene {
        WindowReader { window in
            ...
        }
    }
}
```

On child views the `UIWindow` or `NSWindow` will be available in the `Environment`

## Environment

```swift
@Environment(\.window) var window
```

## License

See [LICENSE](LICENSE)
