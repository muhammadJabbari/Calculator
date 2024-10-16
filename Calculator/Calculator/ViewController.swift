//
//  ViewController.swift
//  Calculator
//
//  Created by Mohammad Jabbari on 8/29/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var valueLabel: UILabel!
    private var brain = CalculatorBrain()
    private var userIsInTheMiddleOfTyping = false
    
    @IBAction func labelDidSwipe(_ sender: UISwipeGestureRecognizer) {
        valueLabel.text?.removeLast()
    }
    
    @IBAction func number(_ sender: UIButton)  {
            let digit = sender.configuration?.title!
            if userIsInTheMiddleOfTyping {
                let currentDigit = valueLabel.text!
                valueLabel.text = currentDigit + digit! 
            }else{
                valueLabel.text = digit
                userIsInTheMiddleOfTyping = true
            }
    }
    var valueLable: Double{
        get {
            Double(valueLabel.text!)!
        }
        set{
            valueLabel.text = String(newValue)
        }
    }
    @IBAction func amaliat(_ sender: UIButton) {
        let operation = sender.configuration!.title!
        
        if userIsInTheMiddleOfTyping{
            brain.setOperand(valueLable)
            userIsInTheMiddleOfTyping = false
        }
        
        brain.setOperator(operation)
        if brain.result != nil {
            valueLable = brain.result!
        }
        
    }
    

}

