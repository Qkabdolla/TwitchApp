//
//  Service.swift
//  TwitchApp
//
//  Created by Kabdolla on 11/6/20.
//

import Foundation
import RxSwift
import RxCocoa

final class DataService {
    
    private let bag: DisposeBag = DisposeBag()
    
    private let networkService: Networking
    private let dbService: DBManager
    
    private var games: [Game] = [] {
        didSet {
            self.subject.onNext(games)
        }
    }
    
    let subject = PublishSubject<[Game]>()
    var page: Int = 0
    
    init(_ networkService: NetworkService, _ dbService: DBService) {
        self.networkService = networkService
        self.dbService = dbService
    }
    
    func fetchAndSaveData() {
        networkService.request(page: page)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .subscribe { [unowned self] (games) in
                self.games.append(contentsOf: games)
                
                if page > 0 {
                    self.dbService.save(games)
                } else {
                    self.dbService.update(games)
                }

                self.page += 1
            } onFailure: { [unowned self] (error) in
                print(error.localizedDescription)
                self.games = self.dbService.fetch()
        }.disposed(by: bag)
    }
    
    func fetchDataFromDb() {
        games = dbService.fetch()
    }
}
