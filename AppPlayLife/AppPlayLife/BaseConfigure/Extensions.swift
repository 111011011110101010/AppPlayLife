import Foundation
import Combine

extension Publisher where Output == Creation {
    func latestThreeSame(sameType: TypeCreation) -> AnyPublisher<Bool, Failure> {
        scan(0) { previousValue, newValue in
            if case sameType = newValue.type {
                if previousValue == 3 {
                    return 1
                }
                return previousValue + 1
            }
            return 0
        }
        .map{ $0 == 3 }
        .filter { $0 }
        .eraseToAnyPublisher()
    }
}
