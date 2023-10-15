//
//  Environment+Window.swift
//  WindowReader
//
//  Created by David Walter on 08.07.23.
//

import SwiftUI

#if os(iOS) || os(tvOS)
private struct WindowKey: EnvironmentKey {
    static var defaultValue: UIWindow? {
        nil
    }
}

private struct WindowLevelKey: EnvironmentKey {
    static var defaultValue: UIWindow.Level {
        .normal
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
    
    /// The window level of this environment.
    ///
    /// Read this environment value from within a view to find the window level for
    /// this presentation. If no `UIWindow.Level` was set then it will default to `.normal`
    public var windowLevel: UIWindow.Level {
        get { self[WindowLevelKey.self] }
        set { self[WindowLevelKey.self] = newValue }
    }
}

extension View {
    /// Sets the window for this presentation. If no window is provided,
    /// the current window will be determined using ``captureWindow(perform:)``
    ///
    /// - Parameter window: The `UIWindow` to use for this presentation
    ///
    /// - Returns: A view where the given or captured window is available for child views
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
    /// - Returns: A view where the current window is available for child views
    public func captureWindow(perform action: ((UIWindow) -> Void)? = nil) -> some View {
        modifier(CaptureWindow(action: action))
    }
}

struct CaptureWindow: ViewModifier {
    @State private var window: UIWindow?
    var action: ((UIWindow) -> Void)?
    
    func body(content: Content) -> some View {
        content
            .readWindow {
                window = $0
                action?($0)
            }
            .environment(\.window, window)
            .environment(\.windowLevel, window?.windowLevel ?? .normal)
    }
}
#elseif os(macOS)
private struct WindowKey: EnvironmentKey {
    static var defaultValue: NSWindow? {
        nil
    }
}

private struct WindowLevelKey: EnvironmentKey {
    static var defaultValue: NSWindow.Level {
        .normal
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
    
    /// The window level of this environment.
    ///
    /// Read this environment value from within a view to find the window level for
    /// this presentation. If no `NSWindow.Level` was set then it will default to `.normal`
    public var windowLevel: NSWindow.Level {
        get { self[WindowLevelKey.self] }
        set { self[WindowLevelKey.self] = newValue }
    }
}

extension View {
    /// Sets the window for this presentation. If no window is provided,
    /// the current window will be determined using ``View/captureWindow``
    ///
    /// - Parameter window: The `NSWindow` to use for this presentation
    ///
    /// - Returns: A view where the given or captured window is available for child views
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
    /// - Returns: A view where the current window is available for child views
    public func captureWindow(perform action: ((NSWindow) -> Void)? = nil) -> some View {
        modifier(CaptureWindow(action: action))
    }
}

struct CaptureWindow: ViewModifier {
    @State private var window: NSWindow?
    var action: ((NSWindow) -> Void)?
    
    func body(content: Content) -> some View {
        content
            .readWindow {
                window = $0
                action?($0)
            }
            .environment(\.window, window)
            .environment(\.windowLevel, window?.level ?? .normal)
    }
}
#endif
