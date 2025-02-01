//
//  WindowReaderRepresentable.swift
//  WindowReader
//
//  Created by David Walter on 01.02.25.
//

import SwiftUI

#if os(iOS) || os(tvOS) || os(visionOS)
struct WindowReaderRepresentable: UIViewRepresentable {
    let initial: Bool
    let onUpdate: (UIWindow) -> Void
    
    init(initial: Bool = true, onUpdate: @escaping (UIWindow) -> Void) {
        self.initial = initial
        self.onUpdate = onUpdate
    }
    
    func makeUIView(context: Context) -> WindowInjectView {
        WindowInjectView(initial: initial, onUpdate: onUpdate)
    }
    
    func updateUIView(_ nsView: WindowInjectView, context: Context) {
    }
}
#elseif os(macOS)
struct WindowReaderRepresentable: NSViewRepresentable {
    let initial: Bool
    let onUpdate: (NSWindow) -> Void
    
    init(initial: Bool = true, onUpdate: @escaping (NSWindow) -> Void) {
        self.initial = initial
        self.onUpdate = onUpdate
    }
    
    func makeNSView(context: Context) -> WindowInjectView {
        WindowInjectView(initial: initial, onUpdate: onUpdate)
    }
    
    func updateNSView(_ nsView: WindowInjectView, context: Context) {
    }
}
#endif
