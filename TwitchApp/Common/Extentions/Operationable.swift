//
//  Operationable.swift
//  TwitchApp
//
//  Created by Kabdolla on 11/16/20.
//

import UIKit

protocol Operationable {}

extension NSObject: Operationable {}
extension AnyHashable: Operationable {}
extension AnyCollection: Operationable {}
extension JSONEncoder: Operationable {}
extension JSONDecoder: Operationable {}
extension Array: Operationable {}
extension Optional: Operationable {}
extension Foundation.Data: Operationable {}
extension Int: Operationable {}
extension Double: Operationable {}
extension String: Operationable {}
extension String.SubSequence: Operationable {}
extension Bool: Operationable {}
extension CGFloat: Operationable {}
extension CGColor: Operationable {}

extension Operationable {
    func takeIf(_ closure: (Self) -> Bool) -> Self? {
        closure(self) ? self : nil
    }

    func apply(_ closure: (Self) -> Void) -> Self {
        closure(self)
        return self
    }

    func also(_ block: () -> Void) -> Self {
        block()
        return self
    }

    @inline(__always) func `let`<R>(block: (Self) -> R) -> R {  block(self) }
}
