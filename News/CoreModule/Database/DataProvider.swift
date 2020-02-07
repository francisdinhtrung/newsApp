//
//  DataProvider.swift
//  News
//
//  Created by Trung Vu on 2/6/20.
//  Copyright © 2020 Trung Vu. All rights reserved.
//

import Realm
import RealmSwift

class DataProvider {
    func objects<T: Object>(_ type: T.Type, predicate: NSPredicate? = nil) -> Results<T>? {
        if !isRealmAccessible() { return nil }
        
        let realm = try! Realm()
        realm.refresh()
        
        return predicate == nil ? realm.objects(type) : realm.objects(type).filter(predicate!)
    }
    
    func object<T: Object>(_ type: T.Type, key: String) -> T? {
        if !isRealmAccessible() { return nil }
        
        let realm = try! Realm()
        realm.refresh()
        
        return realm.object(ofType: type, forPrimaryKey: key)
    }
    
    func add<T: Object>(_ data: [T], update: Bool = true) {
        if !isRealmAccessible() { return }
        
        let realm = try! Realm()
        realm.refresh()
        
        if realm.isInWriteTransaction {
            realm.add(data, update: .all)
        } else {
            try! realm.write {
                realm.add(data, update: .all)
            }
        }
    }
    
    func add<T: Object>(_ data: T, update: Bool = true) {
        add([data], update: update)
    }
    
    func runTransaction(action: () -> Void) {
        if !isRealmAccessible() { return }
        
        let realm = try! Realm()
        realm.refresh()
        
        try? realm.write {
            action()
        }
    }
    
    func delete<T: Object>(_ data: [T]) {
        let realm = try! Realm()
        realm.refresh()
        try? realm.write { realm.delete(data) }
    }
    
    func delete<T: Object>(_ data: T) {
        delete([data])
    }
    
    func clearAllData() {
        if !isRealmAccessible() { return }
        
        let realm = try! Realm()
        realm.refresh()
        try? realm.write { realm.deleteAll() }
    }
}

extension DataProvider {
    func isRealmAccessible() -> Bool {
        do { _ = try Realm() } catch {
            print("Realm is not accessible")
            return false
        }
        return true
    }
    
    func configureRealm() {
        let config = RLMRealmConfiguration.default()
        config.deleteRealmIfMigrationNeeded = true
        RLMRealmConfiguration.setDefault(config)
    }
    
    func configRealm() {
        
        let realmName = "News.1.0.realm"
        
        // Override point for customization after application launch.
        
        let config = Realm.Configuration(
            
            fileURL: URL(fileURLWithPath: RealmPath + realmName),
            
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: UInt64(0),
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 3) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
                
        })
        
        Log.debug(config.fileURL)
        
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
    }
}
