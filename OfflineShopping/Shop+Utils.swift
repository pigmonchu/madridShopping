import CoreData


extension Shop {
    public var opening_hours: String? {
        get {
            if firstPreferredLanguage == "es" {
                return self.opening_hours_es
            } else {
                return self.opening_hours_en
            }
        }
    }
    
    public var briefDescription: String? {
        get {
            if firstPreferredLanguage == "es" {
                return self.description_es
            } else {
                return self.description_en
            }
        }
    }
    
    public struct data {
        let id: Int16
        let address: String
        let description_es: String
        let description_en: String
        let gps_lat: Double
        let gps_lon: Double
        var gps_img: NSData?
        let img_url: String
        var img: NSData?
        let logo_img_url: String
        var logo_img: NSData?
        let name: String
        let opening_hours_es: String
        let opening_hours_en: String
        let url: String
    }

    public convenience init(context: NSManagedObjectContext,
                            id: Int16,
                            address: String,
                            description_en: String,
                            description_es: String,
                            gps_lat: Double,
                            gps_lon: Double,
                            img_url: String,
                            logo_img_url: String,
                            name: String,
                            opening_hours_en: String,
                            opening_hours_es: String,
                            url: String) {
        self.init(context: context)
        self.id = id
        self.address = address
        self.description_es = description_es
        self.description_en = description_en
        self.gps_lat = gps_lat
        self.gps_lon = gps_lon
        self.img_url = img_url
        self.logo_img_url = logo_img_url
        self.name = name
        self.opening_hours_es = opening_hours_es
        self.opening_hours_en = opening_hours_en
        self.url = url
    }

    public convenience init(context: NSManagedObjectContext, data: Shop.data) {
        self.init(context: context,
                  id: data.id,
                  address: data.address,
                  description_en: data.description_en,
                  description_es: data.description_es,
                  gps_lat: data.gps_lat,
                  gps_lon: data.gps_lon,
                  img_url: data.img_url,
                  logo_img_url: data.logo_img_url,
                  name: data.name,
                  opening_hours_en: data.opening_hours_en,
                  opening_hours_es: data.opening_hours_es,
                  url: data.url)
        self.img = data.img
        self.logo_img = data.logo_img
        self.gps_img = data.gps_img
    }

    public func update(data: Shop.data) {
        self.address = data.address
        self.description_es = data.description_es
        self.description_en = data.description_en
        self.gps_lat = data.gps_lat
        self.gps_lon = data.gps_lon
        self.gps_img = data.gps_img
        self.img_url = data.img_url
        self.img = data.img
        self.logo_img_url = data.logo_img_url
        self.logo_img = data.logo_img
        self.name = data.name
        self.opening_hours_es = data.opening_hours_es
        self.opening_hours_en = data.opening_hours_en
        self.url = data.url
    }
    
    
    class func fetchRequestOrderedById() -> NSFetchRequest<Shop> {
        let fetchRequest : NSFetchRequest<Shop> = Shop.fetchRequest()
        fetchRequest.fetchBatchSize = 12
        
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)

        fetchRequest.sortDescriptors = [sortDescriptor]
        
        return fetchRequest
    }
    
    
}
