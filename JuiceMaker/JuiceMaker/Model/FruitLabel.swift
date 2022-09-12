import UIKit
final class FruitLabel: UILabel {
    var fruit: Fruit? {
        guard let identifier = self.restorationIdentifier?.replacingOccurrences(of: "Label", with: "") else {
            return nil
        }
        return Fruit.init(rawValue: identifier)
    }
}
