//
//  Games.swift
//  TwitchApp
//
//  Created by Kabdolla on 11/4/20.
//

import Foundation
import ObjectMapper
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

class Game: Object, Decodable, Mappable{
    
    dynamic var channelsCount: Int?
    dynamic var viewersCount: Int?
    dynamic var gameDetail: GameDetail?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        channelsCount <- map["channels"]
        viewersCount  <- map["viewers"]
        gameDetail    <- map["game"]
    }
}

class GameDetail: Object, Decodable, Mappable {
    dynamic var image: Image?
    dynamic var name: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        image         <- map["box"]
        name          <- map["name"]
    }
}

class Image: Object, Decodable, Mappable {
    
    dynamic var medium: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        medium <- map["medium"]
    }
}
