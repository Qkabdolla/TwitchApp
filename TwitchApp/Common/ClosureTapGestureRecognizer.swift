//
//  ClosureTapGestureRecognizer.swift
//  TwitchApp
//
//  Created by Kabdolla on 11/16/20.
//

import UIKit

final class ClosureTapGestureRecognizer: UITapGestureRecognizer {

    private let action: () -> Void

    init(_ action: @escaping () -> Void) {
        self.action = action
        super.init(target: nil, action: nil)
        addTarget(self, action: #selector(execute))
    }

    @objc func execute() { action() }
}

extension UIView {
    func addTapGestureRecognizer(_ closure: @escaping () -> Void) {
        addGestureRecognizer(ClosureTapGestureRecognizer(closure))
    }
}
