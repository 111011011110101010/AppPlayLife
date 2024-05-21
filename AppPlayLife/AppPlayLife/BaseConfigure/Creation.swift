import Foundation
import UIKit

enum TypeCreation {
    case dead
    case alive
    case life
}

class Creation {
    var type: TypeCreation
    var name: String
    var description: String
    var diedRecently: Bool = false
    
    init(type: TypeCreation) {
        self.type = type
        switch type {
        case .dead:
            self.name = "Мертвая"
            self.description = "или притворяется"
        case .alive:
            self.name = "Живая"
            self.description = "и шевелится"
        case .life:
            self.name = "Жизнь"
            self.description = "Ку-ку!"
        }
    }
    
    func makeDead() {
        self.type = .dead
        self.name = "Мертвая"
        self.description = "или притворяется"
        self.diedRecently = true
    }
}
