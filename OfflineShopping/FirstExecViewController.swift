import UIKit
import CoreData

class FirstExecViewController: UIViewController {

    @IBOutlet weak var backgroundError: UIVisualEffectView!
    @IBOutlet weak var imgLoadError: UIImageView!

    @IBOutlet weak var imgIconoApp: UIImageView!
    @IBOutlet weak var btnWatchShops: UIButton!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var context: NSManagedObjectContext?
    var msg = ""
    var alertProgress: UIAlertController?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
 
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if firstPreferredLanguage == "es" {
            btnWatchShops.titleLabel!.text = "ver Tiendas"
        } else {
            btnWatchShops.titleLabel!.text = "watch Shops"
        }
        
        downloadShopsIfNeeded()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    //MARK: - Flujo
    func downloadShopsIfNeeded() {
        let coreDataInteractor = CoreDataInteractor()
        let shopsInteractor = ShopsInteractor()
        
        do {
            if try coreDataInteractor.thereIsDataInLocal(inContext: context!) {
                self.activityIndicator.stopAnimating()
            } else {
                showDownloadMessage()
                let imgLoadMsg = "Descargando imágenes, por favor no cierre la aplicación.\n"
                shopsInteractor.downloadData(completion: { shops in
                    assert(Thread.current == Thread.main)
                    
                    self.alertProgress?.message = imgLoadMsg
                    shopsInteractor.downloadImages(inShops: shops,
                        completion: { shops in
                        do {
                            try coreDataInteractor.saveRemote(shops: shops, inContext: self.context!)
                            self.activityIndicator.stopAnimating()
                            self.dismiss(animated: true, completion: nil)
//                            self.btnWatchShops.isHidden = false
                        } catch {
                            self.showErrorLoading(error)
                        }

                    },
                        advanceWatcher: { advance in
                            self.alertProgress!.message = imgLoadMsg + "(" + String(format: "%.2f", advance*100) + "%)"
                            
                    })
                }, onError: { (error) in
                    self.showErrorLoading(error)
                })
            }
        } catch {
            self.showErrorLoading(error)
        }
        
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "iniAppSegue" {
                if let navController = segue.destination as? UINavigationController,
                    let vc = navController.topViewController as? ShopsViewController {
                    vc.context = self.context
                }
            }
        }
    }

    //MARK: - Mensajes y fondos
    func showDownloadMessage () {
        self.alertProgress = pushAlertLoading()
        self.present(self.alertProgress!, animated: true, completion: nil)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
//        btnWatchShops.isHidden = true
        self.imgLoadError.isHidden = true
        self.backgroundError.isHidden = true
    }

    func showErrorLoading(_ error: Error) {
        
        let myError = error as? OfflineShoppingErrors
        
        if myError != nil && myError == OfflineShoppingErrors.remoteShopsUrlNotReachable {
            self.msg = "La conexión a internet es necesaria para lanzar por primera vez esta aplicación. Reintente cuando disponga de acceso a la red"
        } else {
            self.msg = "Se ha producido un error al iniciar la aplicación."
        }

        if self.presentedViewController != nil {
            self.dismiss(animated: true) {
                self.showErrorControls(message: self.msg)
            }
        } else  {
            self.showErrorControls(message: self.msg)
        }
        
    }
    
    func showErrorControls(message: String) {
        self.backgroundError.isHidden = false
        self.imgLoadError.isHidden = false
        self.present(self.pushAlertError(message: self.msg), animated: true, completion: nil)
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


