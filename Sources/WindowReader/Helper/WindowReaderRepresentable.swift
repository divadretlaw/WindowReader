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
    let action: (UIWindow) -> Void
    
    init(initial: Bool = true, perform action: @escaping (UIWindow) -> Void) {
        self.initial = initial
        self.action = action
    }
    
    func makeUIView(context: Context) -> WindowInjectView {
        WindowInjectView(initial: initial, perform: action)
    }
    
    func updateUIView(_ nsView: WindowInjectView, context: Context) {
    }
}
#elseif os(macOS)
struct WindowReaderRepresentable: NSViewRepresentable {
    let initial: Bool
    let action: (NSWindow) -> Void
    
    init(initial: Bool = true, perform action: @escaping (NSWindow) -> Void) {
        self.initial = initial
        self.action = action
    }
    
    func makeNSView(context: Context) -> WindowInjectView {
        WindowInjectView(initial: initial, perform: action)
    }
    
    func updateNSView(_ nsView: WindowInjectView, context: Context) {
    }
}
#endif
