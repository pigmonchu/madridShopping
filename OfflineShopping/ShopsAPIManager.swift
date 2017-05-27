import Foundation
import UIKit

public class ShopsAPIManager{
    
    let urlApi = "https://madrid-shops.com/json_new/getShops.php"
    
    typealias JSONObject        = AnyObject
    typealias JSONDictionary    = [String : JSONObject]
    typealias JSONArray         = [JSONDictionary]

    func getAllShops(completion: @escaping ([Shop.data]) throws ->  Void) throws -> Void {
        let dataJson: Data?
        var contextJson : JSONArray = []
        var shops:[Shop.data] = []
        
        dataJson = loadFromRemote()
        
        guard dataJson != nil else {
            throw OfflineShoppingErrors.remoteShopsUrlNotReachable
        }
        
        contextJson = try parse(data: dataJson!)
        
        for dict in contextJson {
            guard let shop = decode(Shop: dict) else {
                continue
            }
            shops.append(shop)
        }
        
        try completion(shops)
    }
    
    func loadFromRemote() -> Data? {
        do {
            let jsonData = try Data(contentsOf: URL(string: urlApi)!)
            print("Remote loading of Madrid Shops")
            return jsonData
        } catch {
            print(mensaje: "Error en acceso a datos en remoto", atError: error)
            return nil
        }
    }
    
    func loadRemoteImg(url: String) throws -> NSData? {
        guard let imgUrl = URL(string: url) else {
            throw OfflineShoppingErrors.wrongURLFormatForJSONResource
        }
        
        guard let imgData = try? Data(contentsOf: imgUrl) else {
            throw OfflineShoppingErrors.urlImgNotReachable
        }
        return imgData as NSData
        
    }
        
    func parse(data: Data) throws -> JSONArray {
        do {
            let dict = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: Any]
            return dict["result"] as! JSONArray
        } catch {
            print(mensaje: "local file json format error", atError: error)
            throw OfflineShoppingErrors.jsonParsingError
        }
        
    }
    
    func decode(Shop json: JSONDictionary) -> Shop.data? {
        do {
            let address = try decodeString(field: "address", Shop: json)
            let description_en = try decodeString(field: "description_en", Shop: json)
            let description_es = try decodeString(field: "description_es", Shop: json)
            let gps_lat = try decodeDouble(field: "gps_lat",Shop: json)
            let gps_lon = try decodeDouble(field: "gps_lon",Shop: json)
            let id = try decodeInt(field: "id",Shop: json)
            let img_url = try decodeString(field: "img",Shop: json)
            let logo_img_url = try decodeString(field: "logo_img",Shop: json)
            let name = try decodeString(field: "name",Shop: json)
            let opening_hours_en = try decodeString(field: "opening_hours_en",Shop: json)
            let opening_hours_es = try decodeString(field: "opening_hours_es",Shop: json)
            let url = try decodeString(field: "url",Shop: json)
            
            
            return Shop.data(id: id,
                             address: address,
                             description_es: description_es,
                             description_en: description_en,
                             gps_lat: gps_lat,
                             gps_lon: gps_lon,
                             gps_img: nil,
                             img_url: img_url,
                             img: nil,
                             logo_img_url: logo_img_url,
                             logo_img: nil,
                             name: name,
                             opening_hours_es: opening_hours_es,
                             opening_hours_en: opening_hours_en,
                             url: url)
            
            
        } catch OfflineShoppingErrors.requiredField {
            return nil
        } catch{
            print("error general \(error)")
            return nil
        }
        
    }
    
    func decodeString(field: String, Shop json: JSONDictionary) throws -> String {
        
        guard let result = json[field] as! String? else
        {
            print("Shop without \(field)")
            throw OfflineShoppingErrors.requiredField
        }
        
        return result.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func decodeDouble(field: String, Shop json: JSONDictionary) throws -> Double {
        
        let resultStr = try decodeString(field: field, Shop: json)
        
        guard let result = Double(resultStr) else
        {
            print("Shop without \(field)")
            throw OfflineShoppingErrors.requiredField
        }
        return result
    }
    
    func decodeInt(field: String, Shop json: JSONDictionary) throws -> Int16 {
        
        let resultStr = try decodeString(field: field, Shop: json)
        
        guard let result = Int16(resultStr) else
        {
            print("Shop without \(field)")
            throw OfflineShoppingErrors.requiredField
        }
        return result
    }
   
}
