//
//  ViewController.swift
//  WaterCounter
//
//  Created by AI on 09.10.2019.
//  Copyright © 2019 iamai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var counterLabel: UILabel!
    private let fileReader = FileReader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        counterLabel.text = "0"
        self.updateCounter()
    }

    @IBAction func onDelPressed(_ sender: Any) {
        self.showInputAlert(type: "del")
    }
    
    @IBAction func onAddPressed(_ sender: Any) {
        self.showInputAlert(type: "add")
    }
    
    private func showInputAlert(type: String) {
        var title = ""
        var buttonTitle = ""
        if type == "add" {
            title = "Add water"
            buttonTitle = "Add"
        } else if type == "del" {
            title = "Delete water"
            buttonTitle = "Delete"
        } else {
            return
        }
        
        let alert = UIAlertController(title: title, message: "Please input value", preferredStyle: .alert)
        alert.addTextField(configurationHandler: {(textField) in
            textField.placeholder = "Value"
            textField.keyboardType = .decimalPad
        })
        let action = UIAlertAction(title: buttonTitle, style: .default) { (alertAction) in
            if alert.textFields != nil {
                let textField = alert.textFields![0] as UITextField
                guard textField.text != nil else {self.showErrorAlert(type: type); return}
                guard let value = Float(textField.text!) else {self.showErrorAlert(type: type); return}
                if type == "add" {
                    let newData = WaterData(value: abs(value))
                    self.fileReader.addWaterData(newData: newData)
                } else if type == "del" {
                    let minusData = value < 0 ? value : -value
                    let newData = WaterData(value: minusData)
                    self.fileReader.addWaterData(newData: newData)
                }
                self.updateCounter()
            }

        }
        let action2 = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(action2)
        alert.addAction(action)
        self.present(alert, animated:true, completion: nil)
    }

    private func showErrorAlert(type: String) {
        let alert = UIAlertController(title: "Error", message: "Need to indut decimal value", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (alertAction) in
            if type == "add" {
                self.onAddPressed(self)
            } else if type == "del"{
                self.onDelPressed(self)
            }
        }
        alert.addAction(action)
        self.present(alert, animated:true, completion: nil)
    }
    
    private func updateCounter() {
        let data = fileReader.waterData
        var sum: Float = 0
        for item in data {
            sum += item.value
        }
        
        self.counterLabel.text = String(sum)
    }
}

