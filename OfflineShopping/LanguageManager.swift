import Foundation

var firstPreferredLanguage: String {
    get  {
        let str = NSLocale.preferredLanguages[0]
        let index = str.index(str.startIndex, offsetBy: 2)
        return str.substring(to: index)
    }
}
