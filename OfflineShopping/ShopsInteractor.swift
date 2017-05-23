import Foundation
import CoreData

public class ShopsInteractor {

    internal var context: NSManagedObjectContext?
    
    let manager: ShopsAPIManager

    public init(context: NSManagedObjectContext) {
        self.context = context
        self.manager = ShopsAPIManager()
    }
    
    public func downloadData(completion: @escaping () -> Void) throws -> Void {
        
        if try thereIsDataInLocal(context: context!) {
            return
        }
        
        try ShopsAPIManager().getAllShops()
        
        completion()
    }

}
