import Foundation
import CoreLocation
import MapKit

extension ShopsViewController : CLLocationManagerDelegate, MKMapViewDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.myLocation = locations.first
    }
    
    func mapViewWillStartLoadingMap(_ mapView: MKMapView) {
        return
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        return
    }
    
    func mapViewWillStartRenderingMap(_ mapView: MKMapView) {
        //TODO ocultar pines
    }
    
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        //TODO mostrar pines
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        var annotationView: MKAnnotationView?
        
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        } else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView?.canShowCallout = true
        }
        
        if let annotationView = annotationView {
            format(annotationView, forAnnotation: annotation)
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let mapAnnotation = view.annotation as? ShopMapPin else {
            return
        }
        
        mapView.setCenter(CLLocationCoordinate2D(latitude: mapAnnotation.shop.gps_lat, longitude: mapAnnotation.shop.gps_lon), animated: true)
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {

        guard let theAnnotation = view.annotation,
            let shopMapPin = theAnnotation as? ShopMapPin else {
                return
        }
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailShopViewController = storyBoard.instantiateViewController(withIdentifier: "detailShopViewController") as! DetailShopViewController
        detailShopViewController.shop = shopMapPin.shop
        
        self.navigationController?.pushViewController(detailShopViewController, animated: true)

    }
    
    func format(_ annotationView: MKAnnotationView, forAnnotation annotation: MKAnnotation) {
        annotationView.canShowCallout = true
        annotationView.image = UIImage(named: "pinLocation")
        
        guard let annotation = annotation as? ShopMapPin else {
            return
        }

        let subtitleView = UILabel()
        subtitleView.font = UIFont(name: "MontserratAlternates-Light", size: 10)
        subtitleView.textColor = UIColor(colorLiteralRed: 0.753, green: 0.224, blue: 0.169, alpha: 1.0)
//            [UIColor colorWithRed:0.753 green:0.224 blue:0.169 alpha:1.0]
        subtitleView.numberOfLines = 1

        subtitleView.text = annotation.shop.opening_hours
        
        annotationView.detailCalloutAccessoryView = subtitleView

        if let logo = annotation.shop.logo_img_40 {
            annotationView.leftCalloutAccessoryView = UIImageView(image: UIImage(data: logo as Data,scale:1.0))
            
        }
        
        annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)

        
    }
}
