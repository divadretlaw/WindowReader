//
//  WindowInjectView.swift
//  WindowReader
//
//  Created by David Walter on 12.08.22.
//

#if os(iOS) || os(tvOS) || os(visionOS)
import UIKit

final class WindowInjectView: UIView {
    var onUpdate: (UIWindow) -> Void
    
    init(onUpdate: @escaping (UIWindow) -> Void) {
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
    var onUpdate: (NSWindow) -> Void
    
    init(onUpdate: @escaping (NSWindow) -> Void) {
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
