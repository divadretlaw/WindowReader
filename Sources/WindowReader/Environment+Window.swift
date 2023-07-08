//
//  Environment+Window.swift
//  WindowReader
//
//  Created by David Walter on 08.07.23.
//

import SwiftUI

#if canImport(UIKit)
struct WindowKey: EnvironmentKey {
    static var defaultValue: UIWindow? {
        nil
    }
}

extension EnvironmentValues {
    /// The window of this environment.
    ///
    /// Read this environment value from within a view to find the window for
    /// this presentation. If no `UIWindow` was set then it will default to `nil`
    public var window: UIWindow? {
        get { self[WindowKey.self] }
        set { self[WindowKey.self] = newValue }
    }
}

extension View {
    /// Sets the window for this presentation. If no window is provided,
    /// the current windows will be determined using `View.captureWindow`
    ///
    /// - Parameter window: The `UIWindow` to use for this presentation
    ///
    /// - Returns: A view where the given or captured windows is available for child views
    @ViewBuilder public func window(_ window: UIWindow? = nil) -> some View {
        if let window = window {
            environment(\.window, window)
        } else {
            modifier(CaptureWindow())
        }
    }
    
    /// Capture the current window of the view and make it available for child views
    ///
    /// - Parameter action: The action to perform when the `UIWindow` is found.
    ///
    /// - Returns: A view where the current windows is available for child views
    public func captureWindow(perform action: ((UIWindow) -> Void)? = nil) -> some View {
        modifier(CaptureWindow(action: action))
    }
}

struct CaptureWindow: ViewModifier {
    @State var window: UIWindow?
    var action: ((UIWindow) -> Void)?
    
    func body(content: Content) -> some View {
        content
            .readWindow {
                window = $0
                action?($0)
            }
            .environment(\.window, window)
    }
}
#else
struct WindowKey: EnvironmentKey {
    static var defaultValue: NSWindow? {
        nil
    }
}

extension EnvironmentValues {
    /// The window of this environment.
    ///
    /// Read this environment value from within a view to find the window for
    /// this presentation. If no `NSWindow` was set then it will default to `nil`
    public var window: NSWindow? {
        get { self[WindowKey.self] }
        set { self[WindowKey.self] = newValue }
    }
}

extension View {
    /// Sets the window for this presentation. If no window is provided,
    /// the current windows will be determined using `View.captureWindow`
    ///
    /// - Parameter window: The `NSWindow` to use for this presentation
    ///
    /// - Returns: A view where the given or captured windows is available for child views
    @ViewBuilder public func window(_ window: NSWindow? = nil) -> some View {
        if let window = window {
            environment(\.window, window)
        } else {
            modifier(CaptureWindow())
        }
    }
    
    /// Capture the current window of the view and make it available for child views
    ///
    /// - Parameter action: The action to perform when the `NSWindow` is found.
    ///
    /// - Returns: A view where the current windows is available for child views
    public func captureWindow(perform action: ((NSWindow) -> Void)? = nil) -> some View {
        modifier(CaptureWindow(action: action))
    }
}

struct CaptureWindow: ViewModifier {
    @State var window: NSWindow?
    var action: ((NSWindow) -> Void)?
    
    func body(content: Content) -> some View {
        content
            .readWindow {
                window = $0
                action?($0)
            }
            .environment(\.window, window)
    }
}
#endif
