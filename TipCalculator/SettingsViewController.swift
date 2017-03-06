//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Anisha Jain on 3/4/17.
//
//

import UIKit

class SettingsViewController: UIViewController {
    
    let userPref = UserPref()
    
    @IBOutlet weak var defaultTipField: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        defaultTipField.selectedSegmentIndex = userPref.getDefaultTip()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func defaultTipSelected(_ sender: Any) {
        userPref.setdefaultTip(defaultTipSegmentIndex: defaultTipField.selectedSegmentIndex)
    }
}
