//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Ben Gohlke on 8/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

enum Currency {
    case cad
    case mxn
}

class ViewController: UIViewController {
    
    // MARK: - Outlets/Properties
    let toCurrencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
    let fromCurrencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    var currency: Currency = Currency.cad
    @IBOutlet weak var fromCurrencyTextField: UITextField!
    @IBOutlet weak var toCurrencyTextField: UITextField!
    
    @IBOutlet weak var toCurrencyLabel: UILabel!
    
    @IBOutlet weak var cadButton: UIButton!
    @IBOutlet weak var mxnButton: UIButton!
    
    // MARK: - Actions
    
    @IBAction func convertButtonTapped(_ sender: UIButton) {
        guard let dollarsNS = fromCurrencyFormatter.number(from:String( fromCurrencyTextField.text!)) else {
            return
        }
        let dollarsDouble: Double = Double(exactly:dollarsNS) ?? 0
        self.toCurrencyTextField.text = "\(toCurrencyFormatter.string(from: NSNumber(value: self.convert(dollarsDouble))) ?? "0")"
    }
    
    @IBAction func cadButtonTapped(_ sender: UIButton) {
        self.cadButton.isSelected = true
        self.mxnButton.isSelected = false
        self.currency = Currency.cad
        self.toCurrencyLabel.text = "Currency (CAD)"
    }
    
    @IBAction func mxnButtonTapped(_ sender: UIButton) {
        self.mxnButton.isSelected = true
        self.cadButton.isSelected = false
        self.currency = Currency.mxn
        self.toCurrencyLabel.text = "Currency (MXN)"
    }
    
    // MARK: - Helper Methods
    func convert(_ dollars: Double) -> Double {
        var exchangeRate: Double = 0.0
        switch self.currency {
        case .cad:
            exchangeRate = 1.32
        case .mxn:
            exchangeRate = 18.98
        }
        return dollars * exchangeRate
    }
}

