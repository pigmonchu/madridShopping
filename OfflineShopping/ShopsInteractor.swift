import Foundation
import CoreData

public class ShopsInteractor {

    let coreDataManager: CoreDataManager
    let concurrentQueue = DispatchQueue(label: "io.OfflineShopping.concurrent", attributes: .concurrent)
    
    public init() {
        self.coreDataManager = CoreDataManager(dbName: "OfflineShopping")
    }
    
    public func downloadData(completion: @escaping () -> Void, onError: ((NSError) -> Void)? = nil ) -> Void {
        
        concurrentQueue.async {
            do {
                let alreadyDataInLocal = try self.coreDataManager.thereIsDataInLocal()
                
                if !alreadyDataInLocal {
                    try ShopsAPIManager().getAllShops(completion: { (shops) in
                        try self.coreDataManager.save(shops: shops)
                    })
                }
                DispatchQueue.main.sync(execute: completion)
                
            } catch {
                let nserror = error as NSError
                guard let onError = onError else {
                    print ("Error download data: \(nserror), \(nserror.userInfo)")
                    return
                }
                onError(nserror)
            }
        }

    }

}
