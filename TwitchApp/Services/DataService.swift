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
            .subscribe { [unowned self] (gamesResponse) in
                
                
                if page > 0 {
                    self.dbService.save(gamesResponse)
                    self.games.append(contentsOf: gamesResponse)
                } else {
                    self.dbService.update(gamesResponse)
                    self.games = gamesResponse
                }

                self.page += 1
            } onFailure: { error in
                print(error.localizedDescription)
        }.disposed(by: bag)
    }
    
    func fetchDataFromDb() {
        self.games = self.dbService.fetch()
    }
}
