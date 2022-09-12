import UIKit

class ModifyingInventoryViewController: UIViewController {
// MARK: -View
    var receivedFruitStore: FruitStore?
    weak var inventoryDelegate: InventoryDelegate?
    
    @IBOutlet var inventoryLabels: [FruitLabel]!
    @IBOutlet var fruitSteppers: [FruitStepper]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpCustomView()
    }
    
    func setUpCustomView() {
        guard let fruitStore = receivedFruitStore else {
            return
        }
        
        Fruit.allCases.forEach { fruit in
            guard let label = inventoryLabels.filter({ $0.fruit == fruit }).first,
                  let inventory = fruitStore.inventoryList[fruit],
            let stepper = fruitSteppers.filter({ $0.fruit == fruit }).first else {
                return
            }
            label.text = inventory.description
            stepper.value = Double(inventory)
        }
    }
    
// MARK: -Action
    @IBAction func changeStepperValue(_ sender: FruitStepper) {
        guard let fruitStore = receivedFruitStore,
              let fruit = sender.fruit,
              let label = inventoryLabels.filter({ $0.fruit == fruit }).first else {
            return
        }
        let value = Int(sender.value)
        fruitStore.changeInventory(of: fruit, to: value)
        label.text = value.description
    }
    
    @IBAction func touchUpCloseButton(_ sender: UIBarButtonItem) {
        inventoryDelegate?.dissmissModifyView()
        dismiss(animated: true, completion: nil)
    }
}
