import UIKit
import CoreData

class ShopsViewController: UIViewController {
    
    var context: NSManagedObjectContext?
    var _fetchedResultsController: NSFetchedResultsController<Shop>? = nil
    
    let numSections = 1

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "showDetailSegue" {
                if let vc = segue.destination as? DetailShopViewController {
                    vc.shop = (sender as! ShopCell).shop
                }
            }
        }
    }
    



}
