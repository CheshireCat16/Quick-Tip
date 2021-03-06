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

    // View that holds the tip and total section - for animation
    @IBOutlet weak var tipAndTotalView: UIView!
    
    // Text field where bill amount is entered
    @IBOutlet weak var billAmountTextField: UITextField!
    
    // Amount of calculated tip
    @IBOutlet weak var tipAmountLabel: UILabel!
    
    // Slider to choose tip amount
    @IBOutlet weak var tipSlider: UISlider!
    
    // display of current tip percentage
    @IBOutlet weak var slideTipPercent: UILabel!
    
    // Total amount of tip
    @IBOutlet weak var totalLabel: UILabel!
    
    // Intial load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide the tip and total view when first loaded
        tipAndTotalView.alpha = 0
        
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
        else if (defaultCurrency == "???") {
            curCurrency = Currency.eur
        }
        else if (defaultCurrency == "??") {
            curCurrency = Currency.gbp
        }
        else if (defaultCurrency == "??") {
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
        
        // Set up initial values to be consistent with currency
        let initAmount = Bill(currency: curCurrency)
        tipAmountLabel.text = initAmount.description
        totalLabel.text = initAmount.description
        billAmountTextField.placeholder = initAmount.description
        
 
        
        
    }
    
    @IBAction func updateSlideTip(_ sender: Any) {
        // Recalculate the tip
        recalculateTip()
    }
    
    // Make sure we're set to default when coming back from the settings page
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Set the default value of the tip slider
        slideTipPercent.text = String(format: "%.f%%", UserDefaults.standard.double(forKey: "tip"))
        tipSlider.value = Float(UserDefaults.standard.double(forKey: "tip"))
        
        // Also update the currency setting
        var defaultCurrency = String(UserDefaults.standard.string(forKey: "currency") ?? "")
        if (defaultCurrency == "$") {
            curCurrency = Currency.usd
        }
        else if (defaultCurrency == "???") {
            curCurrency = Currency.eur
        }
        else if (defaultCurrency == "??") {
            curCurrency = Currency.gbp
        }
        else if (defaultCurrency == "??") {
            curCurrency = Currency.jpy
        }
        else {
            defaultCurrency = "Default"
            curCurrency = Currency.def
        }
        
        // Set values of tip, total, and bill to be consistent with defaults
        let initAmount = Bill(currency: curCurrency)
        tipAmountLabel.text = initAmount.description
        totalLabel.text = initAmount.description
        billAmountTextField.text = ""
        billAmountTextField.placeholder = initAmount.description
        tipAndTotalView.alpha = 0
        
        // Check if we should put in the most recent bill from the last time (less than 10 minutes since last time bill amount was changed)
        let prevClose = UserDefaults.standard.object(forKey: "last exit")
        let curTime = NSDate()
        if ((prevClose != nil) && curTime.timeIntervalSince(prevClose as! Date) < 600 && UserDefaults.standard.string(forKey: "last bill") != "") {
            billAmountTextField.text = UserDefaults.standard.string(forKey: "last bill")
            tipAndTotalView.alpha = 1
            recalculateTip()
        }
        
    }
    
    // Handle typing into the bill
    @IBAction func billChanged(_ sender: Any) {
        // Recalculate the tip
        recalculateTip()
        
        // If the bill is blank, fade out the tip and total
        if (billAmountTextField.text == "" && self.tipAndTotalView.alpha == 1){
            UIView.animate(withDuration: 0.3, animations: {
                self.tipAndTotalView.alpha = 0
            })
        }
        else if (billAmountTextField.text != "" && self.tipAndTotalView.alpha == 0) {
            UIView.animate(withDuration: 0.3, animations: {
                self.tipAndTotalView.alpha = 1
            })
        }
        UserDefaults.standard.set(billAmountTextField.text, forKey: "last bill")
        UserDefaults.standard.set(NSDate(), forKey: "last exit")
    }
    
    
    func recalculateTip() {
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
    
    // Place the current bill value into memory along with current time
    override func viewWillDisappear(_ animated: Bool) {

    }
    
}

