//
//  SettingsViewController.swift
//  Quick Tip
//
//  Created by John Cheshire on 11/20/21.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaultTip: UILabel!
    
    @IBOutlet weak var defaultTipSlider: UISlider!
    
    @IBOutlet weak var currencySelector: UISegmentedControl!
    
    // Setup view on first load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the current value of the slider to the current default
        defaultTip.text = String(format:"%.f%%", UserDefaults.standard.double(forKey: "tip"))
        defaultTipSlider.value = Float(UserDefaults.standard.double(forKey: "tip"))
        
        // Set the currently selected default currency
        let defaultCurrency = String(UserDefaults.standard.string(forKey: "currency") ?? "")
        if (defaultCurrency == "$") {
            currencySelector.selectedSegmentIndex = 1
        }
        else if (defaultCurrency == "€") {
            currencySelector.selectedSegmentIndex = 2
        }
        else if (defaultCurrency == "£") {
            currencySelector.selectedSegmentIndex = 4
        }
        else if (defaultCurrency == "¥") {
            currencySelector.selectedSegmentIndex = 3
        }
        else {
            currencySelector.selectedSegmentIndex = 0
        }
    }
    
    // Update tip percentage whenever slider changes
    @IBAction func slideDefaultChange(_ sender: Any) {
        // Convert value to percentage and update tip percentage
        let slideTipText = round(defaultTipSlider.value)
        defaultTip.text = String(format:"%.f%%", slideTipText)
        UserDefaults.standard.set(defaultTipSlider.value, forKey: "tip")
    }

    @IBAction func currencySelected(_ sender: Any) {
        let curSelectValue = currencySelector.selectedSegmentIndex

        if (curSelectValue == 1) {
            curCurrency = Currency.usd
            UserDefaults.standard.set("$", forKey: "currency")
        }
        else if (curSelectValue == 2) {
            curCurrency = Currency.eur
            UserDefaults.standard.set("€", forKey: "currency")
        }
        else if (curSelectValue == 4) {
            curCurrency = Currency.gbp
            UserDefaults.standard.set("£", forKey: "currency")
        }
        else if (curSelectValue == 3) {
            curCurrency = Currency.jpy
            UserDefaults.standard.set("¥", forKey: "currency")
        }
        else {
            curCurrency = Currency.def
            UserDefaults.standard.set("Default", forKey: "currency")
        }
    }
    
}
