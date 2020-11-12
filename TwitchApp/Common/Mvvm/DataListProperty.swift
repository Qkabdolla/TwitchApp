//
//  Commands.swift
//  TwitchApp
//
//  Created by Kabdolla on 11/4/20.
//

import Foundation
import RxSwift

typealias DataList<T> = DataListProperty<T>

final class DataListProperty<T> {
    fileprivate let subject = BehaviorSubject<[T]>(value: [])

    init() {
    }
    
    init(_ defaultValue: [T]) {
        value = defaultValue
    }
    
    var value: [T] {
        get { try! subject.value() }
        set(v) { subject.onNext(v) }
    }
}

extension DataListProperty {
    func subscribe(to action: @escaping ([T]) -> Void) -> Disposable {
        self.subject.subscribe { action($0.element!) }
    }
}

extension MvvmController {
    func bind<T>(_ property: DataListProperty<T>, to action: @escaping ([T]) -> Void) {
        property.subject.subscribe { action($0.element!) }.disposed(by: bag)
    }
}
