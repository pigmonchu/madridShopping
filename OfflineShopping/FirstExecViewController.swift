import UIKit
import CoreData

class FirstExecViewController: UIViewController {

    @IBOutlet weak var backgroundError: UIVisualEffectView!
    @IBOutlet weak var imgLoadError: UIImageView!

    @IBOutlet weak var imgIconoApp: UIImageView!
    @IBOutlet weak var btnWatchShops: UIButton!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var context: NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        downloadShopsIfNeeded()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    //MARK: - Flujo
    func downloadShopsIfNeeded() {
        do {
            showDownloadMessage()
            try ShopsInteractor(context: self.context!).downloadData {
                self.activityIndicator.stopAnimating()
                self.btnWatchShops.isHidden = false
                self.dismiss(animated: true, completion: nil)
            }
        }
        catch {
            showErrorLoading()
            return
        }
    }

    @IBAction func verTiendas(_ sender: Any) {
    }
    

    //MARK: - Mensajes y fondos
    func showDownloadMessage () {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        btnWatchShops.isHidden = true
        self.imgLoadError.isHidden = true
        self.backgroundError.isHidden = true
        self.present(pushAlertLoading(), animated: true, completion: nil)
    }

    func showErrorLoading() {
        self.dismiss(animated: true) {
            self.backgroundError.isHidden = false
            self.imgLoadError.isHidden = false
            self.present(self.pushAlertError(), animated: true, completion: nil)
        }
    }
    
    internal func pushAlertLoading() -> UIAlertController {
        let alertSheet = UIAlertController(title: "Descargando Datos", message: "Descargando la información, por favor no cierre la aplicación", preferredStyle: .actionSheet)
        return alertSheet
    }
    
    internal func pushAlertError() -> UIAlertController {
        let actionSheet = UIAlertController(title: "Error en la descarga", message: "La conexión a internet es necesaria para lanzar por primera vez esta aplicación", preferredStyle: .actionSheet)
        
        let retryBtn = UIAlertAction(title: NSLocalizedString("Reintentar", comment: ""), style: .default) { (action) in
            self.downloadShopsIfNeeded()
        }
        
        actionSheet.addAction(retryBtn)
        
        return actionSheet
    }
    

}


