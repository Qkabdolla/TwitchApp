//
//  TextProperty.swift
//  TwitchApp
//
//  Created by Kabdolla on 11/16/20.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

typealias Text = TextProperty

final class TextProperty {
    fileprivate let relay: BehaviorRelay<String?>

    init() {
        relay = BehaviorRelay(value: nil)
    }

    init(_ defaultValue: String) {
        relay = BehaviorRelay(value: defaultValue)
    }

    var value: String {
        get { relay.value ?? "" }
        set(v) { relay.accept(v) }
    }
}

extension TextProperty {
    func subscribe(to action: @escaping (String) -> Void) -> Disposable {
        self.relay.subscribe { action($0.element!!) }
    }
}

extension MvvmController {
    func bind(_ property: TextProperty, to vc: UIKit.UIViewController) {
        property.relay.subscribe(onNext: { [weak vc] in vc?.navigationItem.title = $0 }).disposed(by: bag)
    }
}
