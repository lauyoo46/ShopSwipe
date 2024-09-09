import RealmSwift

class CartItem: Object, Identifiable {
    @Persisted(primaryKey: true) var id = UUID()
    @Persisted var product: Product?
    @Persisted var quantity: Int = 0
    
    convenience init(product: Product, quantity: Int) {
        self.init()
        
        self.product = product
        self.quantity = quantity
    }
}
