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
    
    let lostInternetTitle = R.string.localizable.lostInternetConnectionTitle()
    let lostInternetBodyTitle = R.string.localizable.lostInternetConnectionBodyTitle()
    let retryTitle = R.string.localizable.retryTitle()
    
    let launchRatingScreenCommand = Command()
    let refreshing = Visible(true)
    
    var data = DataList<GameListItem>()
    var getMoreDataStatusCounter = 0
    
    init(_ dataService: DataService, _ networkMonitor: NetworkMonitorService) {
        self.dataService = dataService
        self.networkMonitor = networkMonitor
    }
    
    func initialize() {
        title.value = R.string.localizable.mainVCTitle()
        
        networkMonitor.isConnected.subscribe(onNext:  { [unowned self] value in
            if value == true {
                let page = round(Double(self.data.value.count) / 20)
                self.dataService.page = Int(page)
                self.fetchAndSave()
                self.getMoreDataStatusCounter = 0
            } else {
                if self.getMoreDataStatusCounter < 2 {
                    self.showAlert()
                    self.data.value = self.dataService.getDataFromDb().map { GameListItem(from: $0) }
                }
            }
        }).disposed(by: bag)
        
        getData()
    }
    
    func numberOfItems() -> Int {
        return data.value.count
    }
    
    func getItem(by index: Int) -> GameListItem {
        return data.value[index]
    }
    
    private func fetchAndSave() {
        dataService.fetchAndSaveData()
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe {
                self.data.value = self.dataService.getDataFromDb().map { GameListItem(from: $0) }
            } onError: { (error) in
                print(error.localizedDescription)
            }.disposed(by: bag)
    }
    
    func getData() {
        networkMonitor.getInternetStatus()
    }
    
    func refreshData() {
        dataService.page = 0
        getData()
    }
    
    func didTapRatingButton() {
        launchRatingScreenCommand.call()
    }
    
    func didScrollToBottom() {
        getMoreDataStatusCounter += 1
        getData()
    }
    
    private func showAlert() {
        self.showConfirmAlert(title: lostInternetTitle,
                              message: lostInternetBodyTitle,
                              okButtonTitle: retryTitle,
                              customButtonTitle: R.string.localizable.okTitle()) {
            self.getData()
            self.getMoreDataStatusCounter = 0
        }
    }
}
