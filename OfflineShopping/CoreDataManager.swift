import CoreData

public class CoreDataManager {
    
    let context: NSManagedObjectContext
    var container: NSPersistentContainer
    
    let shopsRequest:NSFetchRequest = Shop.fetchRequest()
    let cacheRequest:NSFetchRequest = Cache.fetchRequest()
    
    //MARK: - Initializers
    public init(dbName: String) {
        
        self.container = NSPersistentContainer(name: dbName)
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            if let error = error as NSError? {
                fatalError("🛑Creating CoreData Stack Error❗️ \(error), \(error.userInfo)")
            }
            
        })

        self.context = container.viewContext
    }

    //MARK: - Transacciones
    internal func save(shops: [Shop.data]) throws {
        for shop in shops {
            try shopUpdateOrCreate(shop: shop)
        }

        let cache = Cache(context: context)
        cache.isDownloaded = true
        
        try self.saveContext(context: context)
    }

    public func thereIsDataInLocal() throws -> Bool {
        cacheRequest.fetchBatchSize = 1
    
        let result = try self.context.fetch(cacheRequest)
        return (result.count > 0 && result[0].isDownloaded)
    }

    internal func shopUpdateOrCreate(shop: Shop.data) throws {
        shopsRequest.predicate = NSPredicate(format: "id == %d", shop.id)
        let result = try context.fetch(shopsRequest)
        if result.count == 0 {
            let _ = Shop(context: context, data: shop)
        } else {
            let dbShop = result[0]
            dbShop.update(data: shop)
        }
    }

//MARK: - DB definition
    
    public func persistentContainer(dbName: String, onError: ((NSError) -> Void)? = nil) -> NSPersistentContainer {

        let container = NSPersistentContainer(name: dbName)
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in

            if let error = error as NSError?,
                let onError = onError {
                onError(error)
            }

        })
        return container
        
    }

    public func saveContext(context: NSManagedObjectContext) throws {
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

