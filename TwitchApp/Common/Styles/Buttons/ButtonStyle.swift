//
//  ButtonStyle.swift
//  TwitchApp
//
//  Created by Kabdolla on 11/16/20.
//

import UIKit

class ButtonStyle: ViewStyle, TextStyle {
    let textColor: UIColor?
    let disabledTextColor: UIColor?
    let selectedBackgroundColor: UIColor?
    let textSize: CGFloat?
    let allCaps: Bool
    let font: UIFont?
    let backgroundImage: UIImage?
    let image: UIImage?

    init(_ styleName: String,
         textColor: UIColor? = nil,
         disabledTextColor: UIColor? = nil,
         selectedBackgroundColor: UIColor? = nil,
         textSize: CGFloat? = nil,
         allCaps: Bool = false,
         font: UIFont? = nil,
         backgroundImage: UIImage? = nil,
         image: UIImage? = nil,
         backgroundColor: UIColor? = nil,
         alpha: CGFloat? = nil,
         cornerRadius: CornerRadius? = nil,
         stroke: Stroke? = nil,
         shadow: Shadow? = nil,
         tintColor: UIColor? = nil
    ) {
        self.textColor = textColor
        self.disabledTextColor = disabledTextColor
        self.selectedBackgroundColor = selectedBackgroundColor
        self.textSize = textSize
        self.font = font?.withSize(0)
        self.backgroundImage = backgroundImage
        self.image = image
        self.allCaps = allCaps

        super.init(
                styleName,
                backgroundColor: backgroundColor,
                tintColor: tintColor,
                alpha: alpha,
                cornerRadius: cornerRadius,
                stroke: stroke,
                shadow: shadow
        )
    }
}
