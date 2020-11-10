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
    
    private let dataService: DataService
    let title = R.string.localizable.mainVCTitle()
    
    var data = DataList<GameListItem>()
    
    init(_ dataService: DataService) {
        self.dataService = dataService
    }
    
    func initialize() {
        dataService.subject
            .observe(on: MainScheduler.instance)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .subscribe (onNext: { [unowned self] in
            self.data.value = $0.map { GameListItem(from: $0) }
        } ).disposed(by: bag)
    }
    
    func numberOfItems() -> Int {
        return data.value.count
    }
    
    func getItem(by index: Int) -> GameListItem {
        return data.value[index]
    }
    
    func getData() {
        dataService.fetchAndSaveData()
    }
}
