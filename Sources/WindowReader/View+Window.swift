//
//  View+Extensions.swift
//  WindowReader
//
//  Created by David Walter on 01.02.25.
//

import SwiftUI

#if os(iOS) || os(tvOS) || os(visionOS)
extension View {
    /// Reads the window of the current view
    /// - Parameter onUpdate: Called whenever the window of the view changes.
    public func readWindow(onUpdate: @escaping (UIWindow) -> Void) -> some View {
        modifier(WindowReaderViewModifier(initial: true, onUpdate: onUpdate))
    }
    
    /// Adds an action to be performed when the window of the view changes.
    /// - Parameter perform: Called when the window of the view changes.
    public func onWindowChange(initial: Bool = false, perform: @escaping (UIWindow) -> Void) -> some View {
        modifier(WindowReaderViewModifier(initial: initial, onUpdate: perform))
    }
}

private struct WindowReaderViewModifier: ViewModifier {
    let initial: Bool
    let onUpdate: (UIWindow) -> Void
    
    init(initial: Bool, onUpdate: @escaping (UIWindow) -> Void) {
        self.initial = initial
        self.onUpdate = onUpdate
    }
    
    func body(content: Content) -> some View {
        content.background(WindowReaderRepresentable(initial: initial, onUpdate: onUpdate))
    }
}
#elseif os(macOS)
extension View {
    /// Reads the window of the current view
    /// - Parameter perform: Called whenever the window of the view changes.
    public func readWindow(perform: @escaping (NSWindow) -> Void) -> some View {
        modifier(WindowReaderViewModifier(initial: true, onUpdate: perform))
    }
    
    /// Adds an action to be performed when the window of the view changes.
    /// - Parameter perform: Called when the window of the view changes.
    public func onWindowChange(initial: Bool = false, perform: @escaping (NSWindow) -> Void) -> some View {
        modifier(WindowReaderViewModifier(initial: initial, onUpdate: perform))
    }
}

private struct WindowReaderViewModifier: ViewModifier {
    let initial: Bool
    let onUpdate: (NSWindow) -> Void
    
    init(initial: Bool, onUpdate: @escaping (NSWindow) -> Void) {
        self.initial = initial
        self.onUpdate = onUpdate
    }
    
    func body(content: Content) -> some View {
        content.background(WindowReaderRepresentable(initial: initial, onUpdate: onUpdate))
    }
}
#endif
