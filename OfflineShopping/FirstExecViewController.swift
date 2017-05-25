import UIKit
import CoreData

class FirstExecViewController: UIViewController {

    @IBOutlet weak var backgroundError: UIVisualEffectView!
    @IBOutlet weak var imgLoadError: UIImageView!

    @IBOutlet weak var imgIconoApp: UIImageView!
    @IBOutlet weak var btnWatchShops: UIButton!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var msg = ""
    
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
        showDownloadMessage()
        
        ShopsInteractor().downloadData(completion: {
            assert(Thread.current == Thread.main)
            self.activityIndicator.stopAnimating()
            self.btnWatchShops.isHidden = false
            self.dismiss(animated: true, completion: nil)
        }, onError: { (error) in
            self.showErrorLoading(error)
            
        })
    }

    @IBAction func verTiendas(_ sender: Any) {
    }
    

    //MARK: - Mensajes y fondos
    func showDownloadMessage () {
        self.present(pushAlertLoading(), animated: true, completion: nil)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        btnWatchShops.isHidden = true
        self.imgLoadError.isHidden = true
        self.backgroundError.isHidden = true
    }

    func showErrorLoading(_ error: Error) {
        
        let myError = error as? OfflineShoppingErrors
        
        if myError != nil && myError == OfflineShoppingErrors.remoteShopsUrlNotReachable {
            self.msg = "La conexión a internet es necesaria para lanzar por primera vez esta aplicación. Reintente cuando disponga de acceso a la red"
        } else {
            self.msg = "Se ha producido un error en la descarga de datos. Reintente más tarde"
        }
        
        self.dismiss(animated: true) {
            self.backgroundError.isHidden = false
            self.imgLoadError.isHidden = false
            self.present(self.pushAlertError(message: self.msg), animated: true, completion: nil)
        }
    }
    
    internal func pushAlertLoading() -> UIAlertController {
        let alertSheet = UIAlertController(title: "Descargando Datos", message: "Descargando la información, por favor no cierre la aplicación", preferredStyle: .actionSheet)
        return alertSheet
    }
    
    internal func pushAlertError(message: String) -> UIAlertController {
        let actionSheet = UIAlertController(title: "Error en la descarga", message: message, preferredStyle: .actionSheet)
        
        let retryBtn = UIAlertAction(title: "Reintentar", style: .default) { (action) in
            self.downloadShopsIfNeeded()
        }
        

        // Habilitar un botón de cierre de la app... a apple no le gusta
        // let cancelBtn = UIAlertAction(title: "Salir", style: .cancel) { (action) in
        //     abort()
        // }
        
        actionSheet.addAction(retryBtn)

        // actionSheet.addAction(cancelBtn)
        
        return actionSheet
    }
    

}


