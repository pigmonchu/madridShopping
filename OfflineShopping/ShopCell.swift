

import UIKit

class ShopCell: UICollectionViewCell {
    
    @IBOutlet weak var ShopNameLabel: UILabel!
    @IBOutlet weak var OpeningHoursLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var ShopImageView: UIImageView!
    
    var _shop: Shop?
    var shop: Shop {
        get {
            return _shop!
        }
        
        set {
            _shop = newValue
            ShopNameLabel.text = newValue.name

            OpeningHoursLabel.text = newValue.opening_hours
            
            if let logo = newValue.logo_img {
                logoImageView.image = UIImage(data: logo as Data,scale:1.0)
            }

            if let image = newValue.img {
                ShopImageView.image = UIImage(data: image as Data, scale:1.0)
            }
        }
    }

    override func awakeFromNib() {
        logoImageView.layer.cornerRadius = 22
        logoImageView.clipsToBounds = true
    }
    
}
