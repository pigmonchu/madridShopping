import CoreData

public class CoreDataManager {
    public func persistentContainer(dbName: String, onError: ((NSError) -> Void)? = nil) -> NSPersistentContainer {

        var container = NSPersistentContainer(name: dbName)
        
//        let testError = NSError(domain: "Error de prueba", code: 999, userInfo: nil)
//        if let error = testError as NSError?,
//            let onError = onError {
//            onError(error)
//        }
//        return container
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in

            if let error = error as NSError?,
                let onError = onError,
                let emptyContainer: NSPersistentContainer = nil
                {
                    container = emptyContainer
                    onError(error)
            }

        })
        return container
        
    }

    public func save(context: NSManagedObjectContext) throws {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(mensaje:"Persistency layer error", atError: error)
                throw OfflineShoppingErrors.localDataAccessError
            }
        }
    }
    
}

