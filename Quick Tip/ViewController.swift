//
//  ViewController.swift
//  Quick Tip
//
//  Created by John Cheshire on 11/20/21.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet weak var billAmountTextField: UITextField!
    
    @IBOutlet weak var tipAmountLabel: UILabel!
    
    @IBOutlet weak var tipSlider: UISlider!
    
    @IBOutlet weak var slideTipPercent: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the default tip if none is set
        var currentDefault = UserDefaults.standard.double(forKey: "tip")
        if (currentDefault < 4.0) {
            UserDefaults.standard.set(15.0, forKey: "tip")
            currentDefault = 15.0
        }
        
        
        // Set the default value of the tip slider
        slideTipPercent.text = String(format: "%.f%%", UserDefaults.standard.double(forKey: "tip"))
        tipSlider.value = Float(currentDefault)
        
        // Have the keyboard come up for entering the bill on load
        self.title = "Quick Tip"
        billAmountTextField.becomeFirstResponder()
    }
    
    @IBAction func updateSlideTip(_ sender: Any) {
        // Convert value to percentage and update tip percentage
        let slideTipText = round(tipSlider.value)
        let slideTipDouble = slideTipText / 100
        slideTipPercent.text = String(format:"%.f%%", slideTipText)
        
        // Pull in bill amount from text field input
        let bill = Float(billAmountTextField.text!) ?? 0
        
        
        // Get total tip
        let tip = bill * slideTipDouble
        let total = bill + tip
        
        // Update tip amount
        tipAmountLabel.text = String(format: "$%.2f", tip)
        // Update total amount
        totalLabel.text = String(format: "$%.2f", total)
    }
}

