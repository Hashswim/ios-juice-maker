import UIKit

final class JuiceButton: UIButton {
    var juice: Juice? {
        guard let identifier = self.restorationIdentifier?.replacingOccurrences(of: "Button", with: "") else {
            return nil
        }
        return Juice.init(rawValue: identifier)
    }
}
