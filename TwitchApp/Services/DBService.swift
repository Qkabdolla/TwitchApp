//
//  DBService.swift
//  TwitchApp
//
//  Created by Kabdolla on 11/5/20.
//

import RealmSwift

final class DBService {
    
    func create(_ object: Game) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(object)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func clearAll() {
        do {
            let realm = try Realm()
            try! realm.write {
                realm.deleteAll()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getdata() -> [Any] {
        do {
            let realm = try Realm()
            let objects = realm.objects(Game.self)
            return objects.toArray()
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func fetch<T: Object>(with type: T.Type) throws -> Results<T>? {
        do {
            let realm = try Realm()
            return realm.objects(T.self)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

extension Results {

    func toArray() -> [Any] {
        return self.map{$0}
    }
}
