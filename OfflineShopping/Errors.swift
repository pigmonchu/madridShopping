import Foundation
// Tomado de https://medium.com/@derrickho_28266/swift-3-error-type-ec86feab43e7

enum OfflineShoppingErrors : Int, Error {
    case remoteShopsUrlNotReachable = 1
    case jsonParsingError = 2
    case requiredField = 3
    case localDataAccessError = 4
    case initCoreDataError = 5
    case wrongURLFormatForJSONResource = 6
    case urlImgNotReachable = 7
    
    var localizedDescription: String {
        switch self {

        case .remoteShopsUrlNotReachable:
            return NSLocalizedString("\(OfflineShoppingErrors.self)_\(self)", tableName: String(describing: self), bundle: Bundle.main, value: "Remote Data URL not reachable", comment: "")
        case .jsonParsingError:
            return NSLocalizedString("\(OfflineShoppingErrors.self)_\(self)", tableName: String(describing: self), bundle: Bundle.main, value: "Remote Data format wrong", comment: "")
        case .requiredField:
            return NSLocalizedString("\(OfflineShoppingErrors.self)_\(self)", tableName: String(describing: self), bundle: Bundle.main, value: "Data field required", comment: "")
        case .localDataAccessError:
            return NSLocalizedString("\(OfflineShoppingErrors.self)_\(self)", tableName: String(describing: self), bundle: Bundle.main, value: "Local data access error ", comment: "")
        case .initCoreDataError:
            return NSLocalizedString("\(OfflineShoppingErrors.self)_\(self)", tableName: String(describing: self), bundle: Bundle.main, value: "Init coredata error", comment: "")
        case .wrongURLFormatForJSONResource:
            return NSLocalizedString("\(OfflineShoppingErrors.self)_\(self)", tableName: String(describing: self), bundle: Bundle.main, value: "Wrong remote url data", comment: "")
        case .urlImgNotReachable:
            return NSLocalizedString("\(OfflineShoppingErrors.self)_\(self)", tableName: String(describing: self), bundle: Bundle.main, value: "Remote image resource not reachable", comment: "")
        }
    }
    
    var _code: Int {
        return self.rawValue
    }
}


