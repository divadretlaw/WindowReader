//
//  WindowReader.swift
//  WindowReader
//
//  Created by David Walter on 12.08.22.
//

import SwiftUI

#if os(iOS) || os(tvOS) || os(visionOS)
/// A container view that reads the current window
///
/// This view reads the current window and makes the window
/// available in the `Environment`
public struct WindowReader<Content>: View where Content: View {
    public var content: (UIWindow) -> Content
    
    @State private var window: UIWindow?
    
    public var body: some View {
        if let window = window {
            content(window)
                .environment(\.window, window)
                .environment(\.windowLevel, window.windowLevel)
        } else {
            WindowReaderRepresentable {
                window = $0
            }
            .accessibility(hidden: true)
        }
    }
    
    /// Creates an instance that can reads the current window
    ///
    /// - Parameter content: The reader's content where the window is accessible
    @inlinable public init(@ViewBuilder content: @escaping (UIWindow) -> Content) {
        self.content = content
    }
}

extension View {
    /// Reads the window of the current view
    /// - Parameter onUpdate: Called whenever the window of the view changes.
    public func readWindow(onUpdate: @escaping (UIWindow) -> Void) -> some View {
        modifier(WindowReaderViewModifier(onUpdate: onUpdate))
    }
}

private struct WindowReaderViewModifier: ViewModifier {
    var onUpdate: (UIWindow) -> Void
    
    func body(content: Content) -> some View {
        content.background(WindowReaderRepresentable(onUpdate: onUpdate))
    }
}

private struct WindowReaderRepresentable: UIViewRepresentable {
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
/// available in the `Environment`
public struct WindowReader<Content>: View where Content: View {
    public var content: (NSWindow) -> Content
    
    @State private var window: NSWindow?
    
    public var body: some View {
        if let window = window {
            content(window)
                .environment(\.window, window)
                .environment(\.windowLevel, window.level)
        } else {
            WindowReaderRepresentable {
                window = $0
            }
            .accessibility(hidden: true)
        }
    }
    
    /// Creates an instance that can reads the current window
    ///
    /// - Parameter content: The reader's content where the window is accessible
    @inlinable public init(@ViewBuilder content: @escaping (NSWindow) -> Content) {
        self.content = content
    }
}

extension View {
    /// Reads the window of the current view
    /// - Parameter onUpdate: Called whenever the window of the view changes.
    public func readWindow(onUpdate: @escaping (NSWindow) -> Void) -> some View {
        modifier(WindowReaderViewModifier(onUpdate: onUpdate))
    }
}

private struct WindowReaderViewModifier: ViewModifier {
    var onUpdate: (NSWindow) -> Void
    
    func body(content: Content) -> some View {
        content.background(WindowReaderRepresentable(onUpdate: onUpdate))
    }
}

private struct WindowReaderRepresentable: NSViewRepresentable {
    var onUpdate: (NSWindow) -> Void
    
    func makeNSView(context: Context) -> WindowInjectView {
        WindowInjectView(onUpdate: onUpdate)
    }
    
    func updateNSView(_ nsView: WindowInjectView, context: Context) {
    }
}
#endif

#Preview {
    WindowReader { window in
        VStack {
            VStack(alignment: .leading) {
                Text("Window")
                    .foregroundColor(.primary)
                #if os(iOS) || os(tvOS) || os(visionOS)
                Text(window.debugDescription)
                    .foregroundColor(.secondary)
                #elseif os(macOS)
                Text(window.debugDescription)
                    .foregroundColor(.secondary)
                #endif
            }
            .multilineTextAlignment(.leading)
        }
        .padding()
    }
}
