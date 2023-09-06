# WindowReader

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fdivadretlaw%2FWindowSceneReader%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/divadretlaw/WindowReader)

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fdivadretlaw%2FWindowSceneReader%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/divadretlaw/WindowReader)

Access the current `UIWindow` or `NSWindow` from any SwiftUI view.

## Usage

Read the current `UIWindow` or `NSWindow` with `WindowReader`

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

### Environment

```swift
@Environment(\.window) var window
```

## License

See [LICENSE](LICENSE)
