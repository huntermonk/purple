import FirebaseDatabase
import UIKit

class AreWe {
    static let shared = AreWe()
    var inProduction = false

    private let cellHeight: CGFloat = 32
    private lazy var ref = Database.database().reference().child("production")
    private var refHandle: DatabaseHandle?
    init() {
         refHandle = ref.observe(.value, with: { [unowned self] snapshot in
            self.inProduction = Bool(truncating: snapshot.value as! NSNumber)
            print("in production: \(self.inProduction)")
        })
    }
}
