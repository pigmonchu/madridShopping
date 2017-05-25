import Foundation

public func print(mensaje: String, atError error: Error) {
    let nserror = error as NSError
    print("\(mensaje) \(nserror), \(nserror.userInfo)")
}
