//
//  NetworkMonitorService.swift
//  TwitchApp
//
//  Created by Kabdolla on 11/12/20.
//

import Foundation
import Alamofire
import RxSwift

final class NetworkMonitorService {
    
    private let reachabilityManager = NetworkReachabilityManager(host: "www.google.com")
    
    var isConnected = PublishSubject<Bool>()
    
    func getInternetStatus() {
        reachabilityManager?.startListening { [weak self] status in
            switch status {
            case .notReachable:
                self?.isConnected.onNext(false)
            default:
                self?.isConnected.onNext(true)
            }
        }
    }
}
