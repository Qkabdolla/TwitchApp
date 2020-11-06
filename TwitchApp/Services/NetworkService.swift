//
//  NetworkService.swift
//  TwitchApp
//
//  Created by Kabdolla on 11/3/20.
//

import Alamofire
import RxSwift
import RxCocoa

protocol Networking {
    func request<T: Decodable>() -> Observable<[T]>
}

final class NetworkService: Networking {
    func request<T: Decodable>() -> Observable<[T]> {
        
        let headers: HTTPHeaders = [
          "Client-ID": "sd4grh0omdj9a31exnpikhrmsu3v46",
          "Accept": "application/vnd.twitchtv.v5+json"
        ]
        
        var params: [String : String] = [:]
        params["limit"] = "20"
        
        return Observable.create { (observer) -> Disposable in
            AF.request("https://api.twitch.tv/kraken/games/top", method: .get, parameters: params, headers: headers).validate(statusCode: 200..<300).responseString { response in
                switch response.result {
                case .failure(let error):
                    print(error.localizedDescription)
                    observer.onError(error)
                case .success(let responseString):
                    let data = GamesWrapper(JSONString: responseString)
                    guard let games = data?.top as? [T] else { return }
                    observer.onNext(games)
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
}
