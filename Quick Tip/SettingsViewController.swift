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
    
    // Setup view on first load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the current value of the slider to the current default
        defaultTip.text = String(format:"%.f%%", UserDefaults.standard.double(forKey: "tip"))
        defaultTipSlider.value = Float(UserDefaults.standard.double(forKey: "tip"))
    }
    
    // Update tip percentage whenever slider changes
    @IBAction func slideDefaultChange(_ sender: Any) {
        // Convert value to percentage and update tip percentage
        let slideTipText = round(defaultTipSlider.value)
        defaultTip.text = String(format:"%.f%%", slideTipText)
        UserDefaults.standard.set(defaultTipSlider.value, forKey: "tip")
    }
    
 
}
