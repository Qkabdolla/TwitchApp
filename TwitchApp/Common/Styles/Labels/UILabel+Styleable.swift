//
//  UILabel+Styleable.swift
//  TwitchApp
//
//  Created by Kabdolla on 11/13/20.
//

import UIKit

private var associateKey: Void?

extension UILabel {

    private var textValueObserver: NSKeyValueObservation? {
        get { objc_getAssociatedObject(self, &associateKey) as? NSKeyValueObservation }
        set {
            objc_setAssociatedObject(self, &associateKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }

    @objc override func applyStyle() {
        guard let labelStyle = style as? LabelStyle else { return }

        super.applyStyle()

        if let font = labelStyle.font {
            self.font = font.withSize(self.font.pointSize)
        }

        if let textSize = labelStyle.textSize {
            font = font.withSize(textSize)
        }

        if let textColor = labelStyle.textColor {
            self.textColor = textColor
        }

        if let adjustsFontSizeToFitWidth = labelStyle.adjustsFontSizeToFitWidth {
            self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        }

        if labelStyle.allCaps && textValueObserver == nil {
            textValueObserver = self.observe(\.text, options: [.new]) { [weak self] (_, change) in
                guard let self = self else { return }
                if let newText = change.newValue as? String {
                    if self.text != newText.uppercased() {
                        self.text = newText.uppercased()
                    }
                }
            }
        }
    }
}
