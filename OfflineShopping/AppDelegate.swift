import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let containerId = "OfflineShopping"
    var context: NSManagedObjectContext?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let pre = NSLocale.preferredLanguages[0]

        
        let container = CoreDataManager().persistentContainer(dbName: containerId, onError: { (error) in
            print("Iniatization CoreData Context Error \(error.localizedDescription) \(error.userInfo)")
            fatalError("Persistency Layer Error. Can not start app.")
            //No me gusta un cagao esta forma pero no hay forma de tirar una app en apple. Así que supongo que un usuario que vea una pantalla roja perenne cerrará. Supongo que a este nivel no se puede lanzar un alert, pero no tengo tiempo de mirarlo.
        })
        
        context = container.viewContext

        injectToFirstViewController(context: context!)
        UINavigationBar.appearance().barStyle = .blackOpaque
        return true
    }

    func injectToFirstViewController(context: NSManagedObjectContext) {
        if let initialViewController = window?.rootViewController as? FirstExecViewController
        {
            initialViewController.context = context
        }
//        if let navController = window?.rootViewController as? UINavigationController,
//            let initialViewController = navController.topViewController as? FirstExecViewController
//        {
//            initialViewController.context = context
//        }
    }


}

