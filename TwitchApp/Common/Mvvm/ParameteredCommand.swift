//
//  ParameteredCommand.swift
//  TwitchApp
//
//  Created by Kabdolla on 11/11/20.
//

import Foundation
import RxSwift

typealias TCommand = ParameteredCommand

final class ParameteredCommand<T> {
    fileprivate let subject = PublishSubject<T>()

    func call(_ value: T) { subject.onNext(value) }
}

extension MvvmController {
    func bind<T>(_ command: ParameteredCommand<T>, to action: @escaping (T) -> Void) {
        command.subject.subscribe { action($0.element!) }.disposed(by: bag)
    }
}
