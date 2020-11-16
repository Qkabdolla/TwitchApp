//
//  Button+Styleable.swift
//  TwitchApp
//
//  Created by Kabdolla on 11/16/20.
//

import UIKit

private var associateKey: Void?

extension UIButton {

    private var textValueObserver: NSKeyValueObservation? {
        get { objc_getAssociatedObject(self, &associateKey) as? NSKeyValueObservation }
        set {
            objc_setAssociatedObject(self, &associateKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }

    @objc override func applyStyle() {

        guard let buttonStyle = style as? ButtonStyle else { return }
        super.applyStyle()

        if let font = buttonStyle.font {
            titleLabel?.font = font.withSize(titleLabel!.font.pointSize)
        }

        if let textSize = buttonStyle.textSize {
            titleLabel?.font = titleLabel?.font.withSize(textSize)
        }

        if let textColor = buttonStyle.textColor {
            setTitleColor(textColor, for: .normal)
        }

        if let backgroundImage = buttonStyle.backgroundImage {
            setBackgroundImage(backgroundImage, for: .normal)
        }

        if let image = buttonStyle.image {
            setImage(image, for: .normal)
        }

        if let disabledTextColor = buttonStyle.disabledTextColor {
            setTitleColor(disabledTextColor, for: .disabled)
        }

        if let imageView = self.imageView {
            bringSubviewToFront(imageView)
        }

        if let selectedBackgroundColor = buttonStyle.selectedBackgroundColor, isSelected {
            self.backgroundColor = selectedBackgroundColor
        }

        if buttonStyle.allCaps && textValueObserver == nil {
            textValueObserver = titleLabel?.observe(\.text, options: [.new]) { [weak self] (_, change) in
                guard let self = self else { return }
                if let newText = change.newValue as? String {
                    if self.title(for: .normal) != newText.uppercased() {
                        self.setTitle(newText.uppercased(), for: .normal)
                    }

                }
            }
        }
    }
}
