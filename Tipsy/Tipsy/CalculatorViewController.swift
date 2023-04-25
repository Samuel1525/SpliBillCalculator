//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    var splitNumber = 2
    var tip = 0.1
    var bill : Float?
    var totalAmount : Float?
    @IBOutlet weak var zeroPctButton: UIButton!
    
    @IBOutlet weak var tenPctButton: UIButton!
    
    @IBOutlet weak var twentyPctButton: UIButton!
    
    @IBOutlet weak var billTextField: UITextField!
    
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        billTextField.endEditing(true)
        splitNumber = Int(sender.value)
        splitNumberLabel.text = String(splitNumber)
    }
    
    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        let tipNumber = sender.currentTitle?.dropLast()
        
        tip = Double(tipNumber!)!/100
        
        print("Selected tip is \(tip)")
        
        
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        sender.isSelected = true
        
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        bill = Float(billTextField.text!)
        totalAmount = (1+Float(tip))*bill!
        print("The total bill is \(totalAmount ?? 0) and will be split between \(splitNumber) people")
        
        self.performSegue(withIdentifier: "goToResults", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults"{
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.splitInfo = "Split between \(splitNumber) people, with \(Int(tip*100))% tip."
            
            let finalAmount = totalAmount!/Float(splitNumber)
            destinationVC.splitResult = String(format: "%.2f", finalAmount)
        }
            
    }



}

