//
//  UIBarButton+Ext.swift
//  TwitchApp
//
//  Created by Kabdolla on 11/11/20.
//

import UIKit

extension UIBarButtonItem {
    fileprivate static var key: UInt8 = 0

    fileprivate var actionClosure: (() -> Void)? {
        get { objc_getAssociatedObject(self, &UIBarButtonItem.key) as? () -> Void }
        set {
            objc_setAssociatedObject(self, &UIBarButtonItem.key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            target = self
            action = #selector(didTapButton(sender:))
        }
    }

    func action(_ action: @escaping () -> Void) {
        actionClosure = action
    }

    @objc fileprivate func didTapButton(sender: Any) {
        actionClosure?()
    }
}
