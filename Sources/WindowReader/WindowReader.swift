//
//  WindowReader.swift
//  WindowReader
//
//  Created by David Walter on 12.08.22.
//

import SwiftUI

#if os(iOS) || os(tvOS)
/// A container view that reads the current window
///
/// This view reads the current window and makes the window
/// available in the `Envionment`
public struct WindowReader<Content>: View where Content: View {
    @ViewBuilder var content: (UIWindow) -> Content
    @State private var window: UIWindow?
    
    public var body: some View {
        if let window = window {
            content(window)
                .environment(\.window, window)
        } else {
            _WindowReader {
                window = $0
            }
        }
    }
    
    /// Creates an instance that can reads the current window
    ///
    /// - Parameter content: The reader's content where the window is accessible
    public init(@ViewBuilder content: @escaping (UIWindow) -> Content) {
        self.content = content
    }
}

extension View {
    /// Reads the window of the current view
    /// - Parameter onUpdate: Called whenever the window of the view changes.
    public func readWindow(onUpdate: @escaping (UIWindow) -> Void) -> some View {
        overlay(_WindowReader(onUpdate: onUpdate))
    }
}

private struct _WindowReader: UIViewRepresentable {
    var onUpdate: (UIWindow) -> Void
    
    func makeUIView(context: Context) -> WindowInjectView {
        WindowInjectView(onUpdate: onUpdate)
    }
    
    func updateUIView(_ uiView: WindowInjectView, context: Context) {
    }
}
#elseif os(macOS)
/// A container view that reads the current window
///
/// This view reads the current window and makes the window
/// available in the `Envionment`
public struct WindowReader<Content>: View where Content: View {
    @ViewBuilder var content: (NSWindow) -> Content
    @State private var window: NSWindow?
    
    public var body: some View {
        if let window = window {
            content(window)
                .environment(\.window, window)
        } else {
            _WindowReader {
                window = $0
            }
        }
    }
    
    /// Creates an instance that can reads the current window
    ///
    /// - Parameter content: The reader's content where the window is accessible
    public init(@ViewBuilder content: @escaping (NSWindow) -> Content) {
        self.content = content
    }
}

extension View {
    /// Reads the window of the current view
    /// - Parameter onUpdate: Called whenever the window of the view changes.
    public func readWindow(onUpdate: @escaping (NSWindow) -> Void) -> some View {
        overlay(_WindowReader(onUpdate: onUpdate))
    }
}

private struct _WindowReader: NSViewRepresentable {
    var onUpdate: (NSWindow) -> Void
    
    func makeNSView(context: Context) -> WindowInjectView {
        WindowInjectView(onUpdate: onUpdate)
    }
    
    func updateNSView(_ nsView: WindowInjectView, context: Context) {
    }
}
#endif
