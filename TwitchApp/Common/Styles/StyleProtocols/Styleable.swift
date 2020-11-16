//
//  Styleable.swift
//  TwitchApp
//
//  Created by Kabdolla on 11/13/20.
//

import Foundation

@objc protocol Styleable {
    var styleName: String? { get set }
    var style: Style? { get set }
}
