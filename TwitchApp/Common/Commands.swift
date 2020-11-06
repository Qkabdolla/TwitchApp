//
//  Commands.swift
//  TwitchApp
//
//  Created by Kabdolla on 11/4/20.
//

import Foundation
import RxSwift

//final class Command {
//    fileprivate let subject = PublishSubject<RxVoid>()
//
//    func call() {
//        subject.onNext(RxVoid())
//    }
//}
//
//extension MvvmController {
//    func bind(_ command: Command, to action: @escaping () -> Void) {
//        command.subject.subscribe { _ in action() }.disposed(by: bag)
//    }
//}
//
//typealias TCommand = ParameteredCommand
//
//final class ParameteredCommand<T> {
//    fileprivate let subject = PublishSubject<T>()
//
//    func call(_ value: T) {
//        subject.onNext(value)
//    }
//}
//
//extension MvvmController {
//    func bind<T>(_ command: ParameteredCommand<T>, to action: @escaping (T) -> Void) {
//        command.subject.subscribe { action($0.element!) }.disposed(by: bag)
//    }
//}
