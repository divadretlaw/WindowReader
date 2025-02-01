//
//  WindowInjectView.swift
//  WindowReader
//
//  Created by David Walter on 12.08.22.
//

#if os(iOS) || os(tvOS) || os(visionOS)
import UIKit

final class WindowInjectView: UIView {
    let initial: Bool
    let onUpdate: (UIWindow) -> Void
    
    private var isInitial = true
    
    init(initial: Bool, onUpdate: @escaping (UIWindow) -> Void) {
        self.initial = initial
        self.onUpdate = onUpdate
        super.init(frame: .zero)
        isHidden = true
        isUserInteractionEnabled = false
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        
        defer {
            isInitial = false
        }
        
        if !initial {
            guard !isInitial else { return }
        }
        
        if let window = newWindow {
            onUpdate(window)
        } else {
            // In case there was no window yet, we try again slightly delayed
            // This should never happen but is there just in case
            DispatchQueue.main.async { [weak self] in
                if let window = self?.window {
                    self?.onUpdate(window)
                }
            }
        }
    }
}
#elseif os(macOS)
import AppKit

final class WindowInjectView: NSView {
    let initial: Bool
    let onUpdate: (NSWindow) -> Void
    
    private var isInitial = true
    
    init(initial: Bool, onUpdate: @escaping (NSWindow) -> Void) {
        self.initial = initial
        self.onUpdate = onUpdate
        super.init(frame: .zero)
        isHidden = true
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillMove(toWindow newWindow: NSWindow?) {
        super.viewWillMove(toWindow: newWindow)
        
        defer {
            isInitial = false
        }
        
        if !initial {
            guard !isInitial else { return }
        }
        
        if let window = newWindow {
            onUpdate(window)
        } else {
            // In case there was no window yet, we try again slightly delayed
            // This should never happen but is there just in case
            DispatchQueue.main.async { [weak self] in
                if let window = self?.window {
                    self?.onUpdate(window)
                }
            }
        }
    }
}
#endif
