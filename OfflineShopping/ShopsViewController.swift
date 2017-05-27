import UIKit
import CoreData
import CoreLocation
import MapKit

class ShopsViewController: UIViewController {
    
    var context: NSManagedObjectContext?
    var _fetchedResultsController: NSFetchedResultsController<Shop>? = nil

    var locationManager: CLLocationManager?
    let numSections = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
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
    
    override func viewWillAppear(_ animated: Bool) {
         self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
         self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }


}
