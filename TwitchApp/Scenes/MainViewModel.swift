//
//  MainViewModel.swift
//  TwitchApp
//
//  Created by Kabdolla on 11/4/20.
//

import Foundation
import RxSwift
import RxCocoa
import Realm

final class MainViewModel: ViewModel {
    
    private let networkService: NetworkService
    private let dbService: DBService
    
    let data = [Game]()
    
    init(_ networkService: NetworkService, _ dbService: DBService) {
        self.networkService = networkService
        self.dbService = dbService
    }
    
    func getData() -> Observable<[Game]> {
//        return networkService.request()
        
        Observable.just(1).flatMap { number -> Observable<[Game]> in
            return self.networkService.request()
        }.subscribe { event in
            switch event {
                  case .next(let value):
                    self.dbService.clearAll()
                    value.forEach { self.dbService.create($0) }
                  case .error(let error):
                      print(error)
                  case .completed:
                      print("completed")
              }
        }.disposed(by: bag)
        
        return Observable.create { observer -> Disposable in
            
            if let data = self.dbService.getdata() as? [Game] {
                observer.onNext(data)
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
}
