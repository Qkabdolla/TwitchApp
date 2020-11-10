//
//  Games.swift
//  TwitchApp
//
//  Created by Kabdolla on 11/4/20.
//

import Foundation
import ObjectMapper
import Realm
import RealmSwift

class GamesWrapper: Object, Decodable, Mappable {
    
    dynamic var total: Int?
    dynamic var top: [Game]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        total <- map["_total"]
        top   <- map["top"]
    }
}

final class Game: Object, Decodable, Mappable{
    
    @objc dynamic var channelsCount: Int = 0
    @objc dynamic var viewersCount: Int = 0
    @objc dynamic var gameDetail: GameDetail?
    
    init?(map: Map) {}
    
    required init() {
        super.init()
    }
    
    func mapping(map: Map) {
        channelsCount <- map["channels"]
        viewersCount  <- map["viewers"]
        gameDetail    <- map["game"]
    }
}

final class GameDetail: Object, Decodable, Mappable {
    @objc dynamic var image: Image?
    @objc dynamic var name: String = ""
    
    init?(map: Map) { }
    
    required init() {
        super.init()
    }
    
    
    func mapping(map: Map) {
        image         <- map["box"]
        name          <- map["name"]
    }
}

final class Image: Object, Decodable, Mappable {
    
    @objc dynamic var medium: String = ""
    
    init?(map: Map) {}
    
    required init() {
        super.init()
    }
    
    
    func mapping(map: Map) {
        medium <- map["medium"]
    }
}
