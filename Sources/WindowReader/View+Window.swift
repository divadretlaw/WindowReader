//
//  View+Extensions.swift
//  WindowReader
//
//  Created by David Walter on 01.02.25.
//

import SwiftUI

#if os(iOS) || os(tvOS) || os(visionOS)
extension View {
    /// Adds an action to be performed when the window of the view changes.
    ///
    /// - Parameters:
    ///     - initial: Whether the action should be run when the initial window is read.
    ///     - action: Called when the window of the view changes.
    public func onWindowChange(initial: Bool = false, perform action: @escaping (UIWindow) -> Void) -> some View {
        modifier(WindowReaderViewModifier(initial: initial, perform: action))
    }
}

private struct WindowReaderViewModifier: ViewModifier {
    let initial: Bool
    let action: (UIWindow) -> Void
    
    init(initial: Bool, perform action: @escaping (UIWindow) -> Void) {
        self.initial = initial
        self.action = action
    }
    
    func body(content: Content) -> some View {
        content.background(WindowReaderRepresentable(initial: initial, perform: action))
    }
}
#elseif os(macOS)
extension View {
    /// Adds an action to be performed when the window of the view changes.
    ///
    /// - Parameters:
    ///     - initial: Whether the action should be run when the initial window is read.
    ///     - action: Called when the window of the view changes.
    public func onWindowChange(initial: Bool = false, perform action: @escaping (NSWindow) -> Void) -> some View {
        modifier(WindowReaderViewModifier(initial: initial, perform: action))
    }
}

private struct WindowReaderViewModifier: ViewModifier {
    let initial: Bool
    let action: (NSWindow) -> Void
    
    init(initial: Bool, perform action: @escaping (NSWindow) -> Void) {
        self.initial = initial
        self.action = action
    }
    
    func body(content: Content) -> some View {
        content.background(WindowReaderRepresentable(initial: initial, perform: action))
    }
}
#endif
