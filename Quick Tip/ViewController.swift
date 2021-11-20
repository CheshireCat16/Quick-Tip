//
//  ViewController.swift
//  Quick Tip
//
//  Created by John Cheshire on 11/20/21.
//

import UIKit


// Enum of supported currencies
enum Currency: String, Codable {
    case eur
    case usd
    case jpy
    case gbp
    case def
}

// Struct to handle bill and tip amounts
struct Bill: Codable {
    var amount: Float = 0
    var currency: Currency = Currency.def
}

// Convert currency value to location appropriate string for display
extension Bill: CustomStringConvertible {
    var description: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        if currency != Currency.def {
            formatter.currencyCode = currency.rawValue
        }
        formatter.maximumFractionDigits = 2
        
        let number = NSNumber(value: amount)
        return formatter.string(from: number)!
    }
}

// Holds the current currency
var curCurrency = Currency.def

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
        
        // Set the currency to default if not already set
        var defaultCurrency = String(UserDefaults.standard.string(forKey: "currency") ?? "")
        if (defaultCurrency == "$") {
            curCurrency = Currency.usd
        }
        else if (defaultCurrency == "€") {
            curCurrency = Currency.eur
        }
        else if (defaultCurrency == "£") {
            curCurrency = Currency.gbp
        }
        else if (defaultCurrency == "¥") {
            curCurrency = Currency.jpy
        }
        else {
            defaultCurrency = "Default"
            curCurrency = Currency.def
            UserDefaults.standard.set("Default", forKey: "currency")
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
        var bill = Bill(currency: curCurrency)
        // get raw string value from text box (may contain , instead of .)
        let rawBill = String(billAmountTextField.text ?? "")
        // Replace the , with ., if it's present
        let cleanBill = String(rawBill.replacingOccurrences(of: ",", with: "."))
        bill.amount = Float(cleanBill) ?? 0
        
        // Create tip and totals
        var tip = Bill(currency: curCurrency)
        var total = Bill(currency: curCurrency)
        
        // Get total and tip amounts
        tip.amount = bill.amount * slideTipDouble
        total.amount = bill.amount + tip.amount
        
        // Update tip amount
        tipAmountLabel.text = tip.description
        // Update total amount
        totalLabel.text = total.description
    }
    
    // Make sure we're set to default when coming back from the settings page
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view appeared")
        // Set the default value of the tip slider
        slideTipPercent.text = String(format: "%.f%%", UserDefaults.standard.double(forKey: "tip"))
        tipSlider.value = Float(UserDefaults.standard.double(forKey: "tip"))
        
        // Also update the currency setting
        var defaultCurrency = String(UserDefaults.standard.string(forKey: "currency") ?? "")
        if (defaultCurrency == "$") {
            curCurrency = Currency.usd
        }
        else if (defaultCurrency == "€") {
            curCurrency = Currency.eur
        }
        else if (defaultCurrency == "£") {
            curCurrency = Currency.gbp
        }
        else if (defaultCurrency == "¥") {
            curCurrency = Currency.jpy
        }
        else {
            defaultCurrency = "Default"
            curCurrency = Currency.def
        }
    }
    

}

