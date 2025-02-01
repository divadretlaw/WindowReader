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
        if let window {
            content(window)
                .environment(\.window, window)
                .environment(\.windowLevel, window.windowLevel)
                .onWindowChange { window in
                    self.window = window
                }
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
    public init(@ViewBuilder content: @escaping (UIWindow) -> Content) {
        self.content = content
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
        if let window {
            content(window)
                .environment(\.window, window)
                .environment(\.windowLevel, window.level)
                .onWindowChange { window in
                    self.window = window
                }
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
    public init(@ViewBuilder content: @escaping (NSWindow) -> Content) {
        self.content = content
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
