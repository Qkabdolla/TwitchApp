//
//  MainViewModel.swift
//  TwitchApp
//
//  Created by Kabdolla on 11/4/20.
//

import Foundation
import RxSwift
import RxCocoa

final class MainViewModel: ViewModel {
    
    private let dataService: DataService
    private let networkMonitor: NetworkMonitorService
    
    let title = R.string.localizable.mainVCTitle()
    let lostInternetTitle = R.string.localizable.lostInternetConnectionTitle()
    let lostInternetBodyTitle = R.string.localizable.lostInternetConnectionBodyTitle()
    let retryTitle = R.string.localizable.retryTitle()
    
    private var counter: Int = 0
    
    var data = DataList<GameListItem>()
    
    init(_ dataService: DataService, _ networkMonitor: NetworkMonitorService) {
        self.dataService = dataService
        self.networkMonitor = networkMonitor
    }
    
    func initialize() {
        dataService.subject
            .observe(on: MainScheduler.instance)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .subscribe (onNext: { [unowned self] in
            self.data.value = $0.map { GameListItem(from: $0) }
        } ).disposed(by: bag)
        
        networkMonitor.isConnected.subscribe(onNext:  { value in
            
            if value == true {
                let temp = self.data.value.count
                let dtemp = Double(temp) / 20
                let page = round(dtemp)
                self.dataService.page = Int(page)
                self.dataService.fetchAndSaveData()
                self.counter = 0
            } else {
                
                if self.counter < 2 {
                    self.showAlert()
                    self.counter += 1
                }
    
            }
            
        }).disposed(by: bag)
    }
    
    func numberOfItems() -> Int {
        return data.value.count
    }
    
    func getItem(by index: Int) -> GameListItem {
        return data.value[index]
    }
    
    func getData() {
        networkMonitor.getInternetStatus()
    }
    
    private func showAlert() {
        self.showConfirmAlert(title: lostInternetTitle,
                              message: lostInternetBodyTitle,
                              okButtonTitle: retryTitle,
                              customButtonTitle: R.string.localizable.okTitle()) {
            self.getData()
        }
        
        dataService.fetchDataFromDb()
    }
}
