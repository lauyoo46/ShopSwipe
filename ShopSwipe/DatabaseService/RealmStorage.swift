import RealmSwift

class RealmStorage {
    
    static let shared = RealmStorage()

    private var realm: Realm {
        do {
            return try Realm()
        } catch {
            fatalError("Error initializing Realm: \(error)")
        }
    }

    private init() {}

    func add<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object, update: .modified)
            }
        } catch {
            print("Error adding or updating object in Realm: \(error)")
        }
    }
    
    func add<T: Object>(_ objects: [T], update: Realm.UpdatePolicy = .modified) {
        do {
            try realm.write {
                realm.add(objects, update: update)
            }
        } catch {
            print("Error adding or updating objects in Realm: \(error)")
        }
    }

    func fetch<T: Object>(_ objectType: T.Type) -> Results<T> {
        return realm.objects(objectType)
    }
    
    func delete<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print("Error deleting object from Realm: \(error)")
        }
    }
    
    func update<T: Object>(_ object: T, with updates: @escaping (T) -> Void) {
        do {
            try realm.write {
                updates(object)
            }
        } catch {
            print("Error updating object in Realm: \(error)")
        }
    }
}
