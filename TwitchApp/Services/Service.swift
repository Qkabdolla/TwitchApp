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
    
    init(_ networkService: NetworkService, _ dbService: DBService) {
        self.networkService = networkService
        self.dbService = dbService
    }
    
    private var page = 0
    
    func fetchAndSaveData() {
        guard page >= 0 else { return }
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
                self.page = -1
        }.disposed(by: bag)
    }
}
