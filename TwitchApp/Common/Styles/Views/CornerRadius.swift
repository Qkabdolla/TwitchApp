//
//  CornerRadius.swift
//  TwitchApp
//
//  Created by Kabdolla on 11/16/20.
//

import UIKit

enum CornerRadius {
    case roundedByHeight
    case roundedByWidth
    case with(_ value: CGFloat)
}

import UIKit

struct Stroke {
    let width: CGFloat
    let color: UIColor

    init(width: CGFloat = 1, color: UIColor) {
        self.width = width
        self.color = color
    }
}

import UIKit

struct Shadow {
    let color: UIColor
    let offset: CGSize
    let opacity: Float
    let radius: CGFloat

    init(
        offset: CGSize = CGSize(width: 0, height: 1),
        opacity: Float = 0.5,
        radius: CGFloat = 3,
        color: UIColor = UIColor.gray
    ) {
        self.color = color
        self.offset = offset
        self.opacity = opacity
        self.radius = radius
    }
}
