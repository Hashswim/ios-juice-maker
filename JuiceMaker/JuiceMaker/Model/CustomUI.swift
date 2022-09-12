import UIKit

final class FruitLabel: UILabel {
    var fruit: Fruit? {
        guard let identifier = self.restorationIdentifier?.replacingOccurrences(of: "Label", with: "") else {
            return nil
        }
        return Fruit.init(rawValue: identifier)
    }
}

final class FruitStepper: UIStepper {
    var fruit: Fruit? {
        guard let identifier = self.restorationIdentifier?.replacingOccurrences(of: "Stepper", with: "") else {
            return nil
        }
        return Fruit.init(rawValue: identifier)
    }
}

final class JuiceButton: UIButton {
    var juice: Juice? {
        guard let identifier = self.restorationIdentifier?.replacingOccurrences(of: "Button", with: "") else {
            return nil
        }
        return Juice.init(rawValue: identifier)
    }
}
