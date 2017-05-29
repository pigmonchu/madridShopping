import Foundation
import CoreData
import UIKit

public class ShopsInteractor {

    var shopsApiManager: ShopsAPIManager
    let concurrentQueue = DispatchQueue(label: "io.OfflineShopping.concurrent", attributes: .concurrent)
    var item: Int = 1

    
    public init() {
        self.shopsApiManager = ShopsAPIManager()
    }
    
    public func downloadData(completion: @escaping ([Shop.data]) -> Void, onError: ((NSError) -> Void)? = nil ) -> Void {
        
        concurrentQueue.async {
            do {
                try self.shopsApiManager.getAllShops(completion: { (shops) in
                    DispatchQueue.main.sync{
                        completion(shops)
                    }
                })
            } catch {
                let nserror = error as NSError
                guard let onError = onError else {
                    print ("Error download data: \(nserror), \(nserror.userInfo)")
                    return
                }
                DispatchQueue.main.sync {
                    onError(nserror)
                }
            }
        }
    }
    
    public func downloadImages(inShops shops: [Shop.data], completion: @escaping([Shop.data]) -> Void, advanceWatcher: ((Double) ->Void)? = nil) {

        
        concurrentQueue.async {
            var newShops: [Shop.data] = []
            self.item = 1
            for var shop in shops {
                shop.img = self.extractImage(url: shop.img_url)
                shop.logo_img = self.extractImage(url: shop.logo_img_url)

                if let logo_img = shop.logo_img {
                    let logo = UIImage(data: logo_img as Data, scale:1.0)
                    let logo40 = resizeImageToNSData(image: logo!, maxHeight: 36.0, maxWidth: 36.0)
                    shop.logo_img_40 = logo40
                }
                
                shop.gps_img = self.extractImage(url: self.getURLMap(lat:shop.gps_lat, lon: shop.gps_lon))
                
                
                newShops.append(shop)
                if advanceWatcher != nil {
                    DispatchQueue.main.sync{
                        let advance = Double(self.item)/Double(shops.count)
                        advanceWatcher!(advance)
                    }
                }
                self.item+=1
            }
            
            DispatchQueue.main.sync{
                completion(newShops)
            }
        }
    }

    func getURLMap(lat: Double, lon: Double) -> String {
        return "https://maps.googleapis.com/maps/api/staticmap?center=\(lat),\(lon)&zoom=16&scale=1&size=500x255&maptype=roadmap&format=png&visual_refresh=true&markers=icon:http://lepe.digestivethinking.com/means/images/icn_map_position_shop.png%7Cshadow:true%7C\(lat),\(lon)"
    }
    
    func extractImage(url: String) -> NSData? {
        var dataImg: NSData?
        do {
            dataImg = try self.shopsApiManager.loadRemoteImg(url: url)
        } catch {
            dataImg = nil
//            shop.img_url = coreDataManager._WRONG_JSON_URL
        }
        return dataImg
    }
}
