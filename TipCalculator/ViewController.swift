//
//  ViewController.swift
//  TipCalculator
//
//  Created by Anisha Jain on 3/4/17.
//
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipPercentageField: UISegmentedControl!
    @IBOutlet weak var resultsView: UIView!

    let tipPercentageValues = [0.15, 0.2, 0.25]
    let userPref = UserPref()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let timeIntervalSinceLastSave = userPref.getTimeIntervalSinceLastSave()
        if (timeIntervalSinceLastSave <= 10){
            let (lastSavedBillAmount, lastSavedSelectedTipSegmentindex) = userPref.getAmountWithTip()
            billField.text = "\(lastSavedBillAmount)"
            tipPercentageField.selectedSegmentIndex = lastSavedSelectedTipSegmentindex
        }
        else {
            tipPercentageField.selectedSegmentIndex = userPref.getDefaultTip()
        }
        calculateTip(nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        billField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func calculateTip(_ sender: Any?) {
        
        let billText = billField.text!
        
        switch billText.characters.count {
        case 0:
            setVisible(visible: false)
            return
        case 6:
            billField.deleteBackward()
            return
        default:
            setVisible(visible: true)
        }
        
        let bill = Double(billText) ?? 0
        let tip = bill * tipPercentageValues[tipPercentageField.selectedSegmentIndex]
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", (bill + tip))
    }
    
    func setVisible(visible:Bool) {
        
        var alpha:CGFloat = 0
        if(visible) {
            alpha = 1
            tipPercentageField.isHidden = false
            resultsView.isHidden = false
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.tipPercentageField.alpha = alpha
            self.resultsView.alpha = alpha
        }, completion: { (finished) in
            self.tipPercentageField.isHidden = !visible
            self.resultsView.isHidden = !visible
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        userPref.setAmountWithTip(billAmount: billField.text!,
                                  selectedTipSegmentIndex: tipPercentageField.selectedSegmentIndex)
    }
}

