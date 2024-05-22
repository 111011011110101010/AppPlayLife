import Combine
import UIKit

class MainViewModel {
    private var anyCancallables = Set<AnyCancellable>()
    
    @Published var creations: [Creation] = []
    
    var deadAround = PassthroughSubject<Bool, Never>()
    
    var creationSubject = PassthroughSubject<Creation, Never>()
    
    var closestAlive: (creation: Creation, index: Int)? = nil
    
    init() {
        creationSubject
            .latestThreeSame(sameType: .alive)
            .sink { [unowned self] _ in
                let creation = Creation(type: .life)
                closestAlive = (creation: creation, index: creations.count)
                creations.append(creation)
            }
            .store(in: &anyCancallables)
        
        creationSubject
            .latestThreeSame(sameType: .dead)
            .sink { [unowned self] value in
                closestAlive?.creation.makeDead()
                deadAround.send(value)
            }
            .store(in: &anyCancallables)
    }
    
    func create() {
        let creation: Creation
        if Int.random(in: 0...1) == 0 {
            creation = Creation(type: .alive)
        } else {
            creation = Creation(type: .dead)
        }
        creations.append(creation)
        creationSubject.send(creation)
    }
                    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CellViewModel {
        let creation = creations[indexPath.row]
        return CellViewModel(creation: creation)
    }
}
