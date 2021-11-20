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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func slideDefaultChange(_ sender: Any) {
        // Convert value to percentage and update tip percentage
        let slideTipText = round(defaultTipSlider.value)
        defaultTip.text = String(format:"%.f%%", slideTipText)
    }
    

}
