import RealmSwift

class Product: Object, Identifiable, Codable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var title: String = ""
    @Persisted var price: Double = 0.0
    @Persisted var image: String = ""
    @Persisted var productDescription: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case image
        case productDescription = "description"
    }
}
