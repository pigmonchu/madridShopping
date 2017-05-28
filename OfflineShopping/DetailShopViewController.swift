import UIKit
import CoreData

class DetailShopViewController: UIViewController {

    @IBOutlet weak var imgShop: UIImageView!
    @IBOutlet weak var imgLogoShop: UIImageView!
    @IBOutlet weak var imgMapLoc: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UITextView!
    @IBOutlet weak var lblOpeningHours: UILabel!

    @IBOutlet weak var lblLocalization: UILabel!

    var shop: Shop?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let theShop = shop else {
            return
        }
        
        lblName.text = theShop.name
        lblOpeningHours.text = theShop.opening_hours
        lblDescription.text = theShop.briefDescription
        
        if let address = theShop.address {
            lblLocalization.text = " " + address
        }
        
        if let logo = theShop.logo_img {
            imgLogoShop.image = UIImage(data: logo as Data,scale:1.0)
            imgLogoShop.layer.cornerRadius = 33
            imgLogoShop.clipsToBounds = true
        }
        
        if let image = theShop.img {
            imgShop.image = UIImage(data: image as Data, scale:1.0)
        }
        
        if let mapImage = theShop.gps_img {
            imgMapLoc.image = UIImage(data: mapImage as Data, scale:1.0)
        }
        
    }

}
