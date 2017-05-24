import Foundation
import CoreData

public class ShopsInteractor {

    let coreDataManager: CoreDataManager

    public init() {
        self.coreDataManager = CoreDataManager(dbName: "OfflineShopping")
    }
    
    public func downloadData(completion: @escaping () -> Void) throws -> Void {
        
        if try coreDataManager.thereIsDataInLocal() {
            completion()
            return
        }
        
        try ShopsAPIManager().getAllShops(completion: { (shops) in
            try self.coreDataManager.save(shops: shops)
            completion()
        })

    }

}
