//
//  DBService.swift
//  TwitchApp
//
//  Created by Kabdolla on 11/5/20.
//

import RealmSwift

protocol DBManager {
    func update(_ objects: [Game])
    func fetch() -> [Game]
    func save(_ objects: [Game])
}

final class DBService: DBManager {
    
    private lazy var realm: Realm = {
        let rlm: Realm
        
        do {
            rlm = try Realm()
        } catch let error{
            fatalError(error.localizedDescription)
        }
        
        return rlm
    }()
    
    func update(_ objects: [Game]) {
        do {
            try realm.write {
                realm.deleteAll()
                realm.add(objects)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func save(_ objects: [Game]) {
        do {
            try realm.write {
                realm.add(objects)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetch() -> [Game] {
        let objects = realm.objects(Game.self)
        return Array(objects)
    }
}
