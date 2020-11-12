//
//  Applicable.swift
//  TwitchApp
//
//  Created by Kabdolla on 11/9/20.
//

import Foundation

public protocol Applicable { }

public extension Applicable {
    func apply(_ closure:(Self) -> Void) -> Self {
        closure(self)
        return self
    }
}

extension NSObject : Applicable { }
extension AnyHashable : Applicable { }
extension AnyCollection : Applicable { }
extension JSONEncoder : Applicable { }
extension JSONDecoder : Applicable { }
extension Array : Applicable where Element: Applicable { }
extension Optional : Applicable where Wrapped: Applicable { }
