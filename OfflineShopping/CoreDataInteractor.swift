import Foundation
import CoreData

public class CoreDataInteractor {

    //Valores por defecto del modelo
    public let _WRONG_JSON_URL = "not img"
    
    let shopsRequest:NSFetchRequest = Shop.fetchRequest()
    let cacheRequest:NSFetchRequest = Cache.fetchRequest()
    
    //MARK: - Transacciones
    internal func saveRemote(shops: [Shop.data], inContext context: NSManagedObjectContext) throws {
        for shop in shops {
            try shopUpdateOrCreate(shop: shop, inContext: context)
        }
        
        let cache = Cache(context: context)
        cache.isDownloaded = true
        
        try CoreDataManager().save(context: context)
    }
    
    public func thereIsDataInLocal(inContext context: NSManagedObjectContext) throws -> Bool {
        cacheRequest.fetchBatchSize = 1
        
//        throw OfflineShoppingErrors.localDataAccessError
        
        let result = try context.fetch(cacheRequest)
        return (result.count > 0 && result[0].isDownloaded)
    }
    
    internal func shopUpdateOrCreate(shop: Shop.data, inContext context: NSManagedObjectContext) throws {
        shopsRequest.predicate = NSPredicate(format: "id == %d", shop.id)
        let result = try context.fetch(shopsRequest)
        if result.count == 0 {
            let _ = Shop(context: context, data: shop)
        } else {
            let dbShop = result[0]
            dbShop.update(data: shop)
        }
    }
    
    public func allShops(inContext context: NSManagedObjectContext) throws -> [Shop] {
        shopsRequest.predicate = nil
        let result = try context.fetch(shopsRequest)
        return result
    }
    

}
