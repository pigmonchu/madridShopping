import UIKit

class DetailShopViewController: UIViewController {

    @IBOutlet weak var imgShop: UIImageView!
    @IBOutlet weak var imgLogoShop: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblOpeningHours: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblLocalization: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblName.text = "Cortefiel - Preciados"
        lblOpeningHours.text = "De Lunes a Sábado: 10:00 - 21:00"
        lblDescription.text = "Una extensa red de tiendas distribuidas por cuatro continentes convierte a Grupo Cortefiel en una de las principales compañías europeas del sector moda. A través de sus cuatro cadenas –Cortefiel, Pedro del Hierro, Springfield y Women’secret-, el Grupo está presente en 58 países con 1.647 puntos de venta."
        
        lblLocalization.text = "Puerta del Sol, 11"

    }


}
