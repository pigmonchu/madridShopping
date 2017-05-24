import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let containerId = "OfflineShopping"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
    }

//    func injectContextToFirstViewController() {
//        if let navController = window?.rootViewController as? UINavigationController,
//            let initialViewController = navController.topViewController as? FirstExecViewController
//        {
//            initialViewController.context = self.context
//        }
//    }


}

