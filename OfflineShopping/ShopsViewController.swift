import UIKit
import CoreData
import CoreLocation
import MapKit

class ShopsViewController: UIViewController {
    
    var context: NSManagedObjectContext?
    var _fetchedResultsController: NSFetchedResultsController<Shop>? = nil

    @IBOutlet weak var mapView: MKMapView!
    let reuseIdentifier = "ShopMapPin"
    
    var locationManager: CLLocationManager?
    let centerAppLocation = CLLocation(latitude:  40.4168833, longitude: -3.7046291) // Puerta del Sol
    var iniRegion: MKCoordinateRegion?
    var myLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        iniMapa()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.mapView.setRegion(iniRegion!, animated: true)
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

    private func iniMapa() {
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.startUpdatingLocation()

        locationManager?.delegate = self
        self.mapView.delegate = self
        
        self.iniRegion = MKCoordinateRegion(center: centerAppLocation.coordinate, span: MKCoordinateSpanMake(0.01, 0.01))
        self.loadPins()
    }
    
    private func loadPins() {
        guard let shops = self.fetchedResultsController.fetchedObjects else {
            return
        }
        
        for shop in shops {
            let pin = ShopMapPin(shop: shop)
            self.mapView.addAnnotation(pin)
        }
    }
}
