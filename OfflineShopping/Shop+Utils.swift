import CoreData


extension Shop {
    public convenience init(context: NSManagedObjectContext,
                            id: Int16,
                            address: String,
                            description_en: String,
                            description_es: String,
                            gps_lat: Double,
                            gps_lon: Double,
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
        self.name = name
        self.opening_hours_es = opening_hours_es
        self.opening_hours_en = opening_hours_en
        self.url = url
    }

    internal convenience init(context: NSManagedObjectContext, data: Shop.data) {
        self.init(context: context,
                  id: data.id,
                  address: data.address,
                  description_en: data.description_en,
                  description_es: data.description_es,
                  gps_lat: data.gps_lat,
                  gps_lon: data.gps_lon,
                  name: data.name,
                  opening_hours_en: data.opening_hours_en,
                  opening_hours_es: data.opening_hours_es,
                  url: data.url)
    }

    struct data {
        let id: Int16
        let address: String
        let description_es: String
        let description_en: String
        let gps_lat: Double
        let gps_lon: Double
        let name: String
        let opening_hours_es: String
        let opening_hours_en: String
        let url: String
    }
    

}
