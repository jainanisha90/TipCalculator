//
//  UserPref.swift
//  TipCalculator
//
//  Created by Anisha Jain on 3/4/17.
//
//

import Foundation
class UserPref{
    
    let defaults = UserDefaults.standard
    let KEY_DEFAULT_TIP_INDEX = "SAVED_DEFAULT_TIP_INDEX"
    let KEY_SAVE_TIME = "SAVED_TIME"
    let KEY_BILL_AMOUNT = "SAVED_BILL_AMOUNT"
    let KEY_SELECTED_TIP_INDEX = "SAVED_SELECTED_TIP_INDEX"
    
    func getDefaultTip()-> Int {
        let defaultTipSegmentIndex = defaults.integer(forKey: KEY_DEFAULT_TIP_INDEX)
        return defaultTipSegmentIndex
    }
    
    func setdefaultTip(defaultTipSegmentIndex: Int) {
        defaults.set(defaultTipSegmentIndex, forKey: KEY_DEFAULT_TIP_INDEX)
    }
    
    func getTimeIntervalSinceLastSave()->Double {
        let lastSavedTime = defaults.double(forKey: KEY_SAVE_TIME)
        print("Time during get \(lastSavedTime)")
        let timeIntervalSinceLastSave = (Date().timeIntervalSinceReferenceDate - lastSavedTime) / 60
        print("Time interval \(timeIntervalSinceLastSave)")
        return timeIntervalSinceLastSave
    }
    
    func setCurrentTime() {
        let time = Date().timeIntervalSinceReferenceDate
        print("Time during set \(time)")
        defaults.set(time, forKey: KEY_SAVE_TIME)
    }
    
    func getAmountWithTip()->(String, Int) {
        let billAmount = defaults.string(forKey: KEY_BILL_AMOUNT)!
        let selectedTipSegmentindex = defaults.integer(forKey: KEY_SELECTED_TIP_INDEX)
        return (billAmount, selectedTipSegmentindex)
    }
    
    func setAmountWithTip(billAmount: String, selectedTipSegmentIndex: Int) {
        defaults.set(billAmount, forKey: KEY_BILL_AMOUNT)
        defaults.set(selectedTipSegmentIndex, forKey: KEY_SELECTED_TIP_INDEX)
    }

}
