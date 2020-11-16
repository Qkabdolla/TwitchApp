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
    
    private let networkService: Networking
    private let dbService: DBManager

    var page: Int = 0
    
    init(_ networkService: NetworkService, _ dbService: DBService) {
        self.networkService = networkService
        self.dbService = dbService
    }
    
    func fetchAndSaveData() -> Completable {
        return networkService.request(page: page).do { [unowned self] (gamesResponse) in
            if page > 0 {
                self.dbService.save(gamesResponse)
            } else {
                self.dbService.update(gamesResponse)
            }
        }.asCompletable()
    }
    
    func getDataFromDb() -> [Game] {
        return self.dbService.get()
    }
}
