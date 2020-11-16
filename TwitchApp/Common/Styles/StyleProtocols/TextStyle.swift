//
//  TextStyle.swift
//  TwitchApp
//
//  Created by Kabdolla on 11/13/20.
//

import UIKit

protocol TextStyle {
    var textColor: UIColor? { get }
    var textSize: CGFloat? { get }
    var font: UIFont? { get }
    var allCaps: Bool { get }
}
