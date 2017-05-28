import Foundation
import MapKit

class ShopMapPin: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    let shop: Shop

    init(shop: Shop) {
        self.shop = shop
        self.coordinate = CLLocationCoordinate2D(latitude: shop.gps_lat, longitude: shop.gps_lon)
        if let name = shop.name {
            self.title = name
        }
        if let opening = shop.opening_hours_es {
            self.subtitle = opening
        }
        
    }
}

class ShopMapPinView: MKAnnotationView {
    
}
