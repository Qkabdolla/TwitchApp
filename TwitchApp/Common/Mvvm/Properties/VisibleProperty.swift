//
//  VisibleProperty.swift
//  TwitchApp
//
//  Created by Kabdolla on 11/16/20.
//

import RxSwift
import RxRelay
import UIKit

typealias Visible = VisibleProperty

final class VisibleProperty {
    fileprivate let relay: BehaviorRelay<Bool>

    init() {
        relay = BehaviorRelay(value: false)
    }

    init(_ defaultValue: Bool) {
        relay = BehaviorRelay(value: defaultValue)
    }

    var value: Bool {
        get { relay.value }
        set(v) { relay.accept(v) }
    }
}

extension MvvmController {
    func bind( _ property: VisibleProperty, to refreshControl: UIRefreshControl) {
        property.relay
                .subscribe {
                    if $0.element! {
                        refreshControl.beginRefreshing()
                    } else {
                        refreshControl.endRefreshing()
                    }
                }
                .disposed(by: bag)
    }
}
