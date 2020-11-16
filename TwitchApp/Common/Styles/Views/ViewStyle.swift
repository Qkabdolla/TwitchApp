//
//  ViewStyle.swift
//  TwitchApp
//
//  Created by Kabdolla on 11/13/20.
//

import UIKit

class ViewStyle: Style {
    let name: String
    let backgroundColor: UIColor?
    let alpha: CGFloat?
    let cornerRadius: CornerRadius?
    let stroke: Stroke?
    let shadow: Shadow?
    let tintColor: UIColor?

    init(_ styleName: String,
         backgroundColor: UIColor? = nil,
         tintColor: UIColor? = nil,
         alpha: CGFloat? = nil,
         cornerRadius: CornerRadius? = nil,
         stroke: Stroke? = nil,
         shadow: Shadow? = nil
    ) {
        self.name = styleName
        self.backgroundColor = backgroundColor
        self.alpha = alpha
        self.cornerRadius = cornerRadius
        self.stroke = stroke
        self.shadow = shadow
        self.tintColor = tintColor
    }
}
