//
//  Command.swift
//  TwitchApp
//
//  Created by Kabdolla on 11/11/20.
//

import Foundation
import RxSwift

final class Command {
    fileprivate let subject = PublishSubject<Void>()

    func call() { subject.onNext(()) }
}

extension MvvmController {
    func bind(_ command: Command, to action: @escaping () -> Void) {
        command.subject.subscribe { _ in action() }.disposed(by: bag)
    }
}
