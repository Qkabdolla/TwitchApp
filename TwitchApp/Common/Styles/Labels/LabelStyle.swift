//
//  LabelStyle.swift
//  TwitchApp
//
//  Created by Kabdolla on 11/13/20.
//

import UIKit

class LabelStyle: ViewStyle, TextStyle {
    let textColor: UIColor?
    let textSize: CGFloat?
    let font: UIFont?
    let adjustsFontSizeToFitWidth: Bool?
    let allCaps: Bool
    
    init(_ styleName: String,
         textColor: UIColor? = nil,
         textSize: CGFloat? = nil,
         allCaps: Bool = false,
         font: UIFont? = nil,
         adjustsFontSizeToFitWidth: Bool? = nil,
         backgroundColor: UIColor? = nil,
         alpha: CGFloat? = nil
    ) {
        self.textColor = textColor
        self.textSize = textSize
        self.font = font?.withSize(17)
        self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        self.allCaps = allCaps

        super.init(
                styleName,
                backgroundColor: backgroundColor,
                alpha: alpha
        )
    }
}
