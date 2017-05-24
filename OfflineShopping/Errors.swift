import Foundation

enum OfflineShoppingErrors : Error {
    case remoteShopsUrlNotReachable
    case jsonParsingError
    case requiredField
    case localDataAccessError
    case initCoreDataError
}


