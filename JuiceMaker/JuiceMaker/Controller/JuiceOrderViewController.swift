//
//  JuiceMaker - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class JuiceOrderViewController: UIViewController {
//MARK: -View
    @IBOutlet private var fruitLabels: [FruitLabel]!
    
    private let juiceMaker = JuiceMaker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        updateInventory()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as? UINavigationController

        guard let nextViewController = navigationController?.viewControllers.first as? ModifyingInventoryViewController else {
            return
        }
        
        nextViewController.inventoryDelegate = self
        nextViewController.receivedFruitStore = juiceMaker.fruitStore
    }
    
    func updateInventory() {
        fruitLabels.forEach { label in
            if let fruit = label.fruit,
               let inventory = juiceMaker.fruitStore.inventoryList[fruit] {
                label.text = inventory.description
            }
        }
    }
    
//MARK: -Action
    @IBAction func touchUpOrderButton(_ sender: JuiceButton) {
        guard let juice = sender.juice else {
                  return
              }
        let result = juiceMaker.make(juice)
        showAlert(about: result)
    }
    
    @IBAction func touchUpModifyButton(_ sender: UIBarButtonItem) {
        self.showModifyingInventoryView()
    }
    
//MARK: -Alert
    func showAlert(about result: Result<Juice, FruitStoreError>) {
        let message: String
        let successFlag: Bool
        
        switch result {
        case .success(let juice):
            updateInventory()
            message = "\(juice.name) 나왔습니다! 맛있게 드세요!"
            successFlag = true
        case .failure:
            message = "재료가 모자라요. 재고를 수정할까요?"
            successFlag = false
        }
        
        let alert = UIAlertController(title: nil,
                                      message: message,
                                      preferredStyle: .alert)
        let alertActions = obtainAlertActions(flag: successFlag)
        alertActions.forEach {
            alert.addAction($0)
        }
        
        present(alert,
                animated: true,
                completion: nil)
    }
    
    func obtainAlertActions(flag: Bool) -> [UIAlertAction] {
        var alertActions: [UIAlertAction] = []
        if flag {
            alertActions.append(UIAlertAction(title: "확인",
                                              style: .default,
                                              handler: nil))
        } else {
            alertActions.append(UIAlertAction(title: "예",
                                              style: .default) { (action) in
                self.showModifyingInventoryView()
            })
            alertActions.append(UIAlertAction(title: "아니오",
                                              style: .default,
                                              handler: nil))
        }
        return alertActions
    }
    
//MARK: -ViewChange
    func showModifyingInventoryView() {
        performSegue(withIdentifier: "modifyInventory", sender: nil)
    }
}

//MARK: -Delegate
extension JuiceOrderViewController: InventoryDelegate {
    func dissmissModifyView() {
        updateInventory()
    }
}
