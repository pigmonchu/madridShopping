import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var context: NSManagedObjectContext?
    let containerId = "OfflineShopping"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let container = persistentContainer(dbName: containerId) { (error: NSError) in
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
        
        self.context = container.viewContext
        injectContextToFirstViewController()
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        guard let context = self.context else { return }
        saveContext(context: context)
    }

    func injectContextToFirstViewController() {
        if let navController = window?.rootViewController as? UINavigationController,
            let initialViewController = navController.topViewController as? FirstExecViewController
        {
            initialViewController.context = self.context
        }
    }


}

