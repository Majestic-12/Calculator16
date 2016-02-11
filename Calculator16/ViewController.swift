//
//  ViewController.swift
//  Calculator16
//
//  Created by Dan Park on 2/9/16.
//  Copyright © 2016 Dan Park. All rights reserved.
//

import UIKit

typealias BinaryOperation = (Double, Double) -> Double
let operations: [String: BinaryOperation] = [ "+" : add, "-" : subtract, "*" : multiply, "/" : divide ]

func add(a: Double, b: Double) -> Double {
    return a + b
}
func subtract(a: Double, b: Double) -> Double {
    return a - b
}
func multiply(a: Double, b: Double) -> Double {
    return a * b
}
func divide(a: Double, b: Double) -> Double {
    return a / b
}

class ViewController: UIViewController {
    
    @IBOutlet var numberField: UITextField!

    var result: Double = 0
    var enteredDigits = ""
    
    var numberStack: [Double] = []
    var operandStack: [String] = []
    
    func hasIndex(stringToSearch str: String, characterToFind chr: Character) -> Bool {
        for c in str.characters {
            if c == chr {
                return true
            }
        }
        return false
    }
    
    func parseDigit(str: String) {
        if str == "-" {
            if enteredDigits.hasPrefix(str) {
                // Strip off the first character (a dash)
                enteredDigits = enteredDigits.substringFromIndex(enteredDigits.startIndex.successor())
            } else {
                enteredDigits = str + enteredDigits
            }
        } else {
            enteredDigits += str
        }
        result = Double((enteredDigits as NSString).doubleValue)
        updateNumberField()
    }
    
    func updateNumberField() {
        let resultInt = Int(result)
        if result - Double(resultInt) == 0 {
            numberField.text = "\(resultInt)"
        } else {
            numberField.text = "\(result)"
        }
    }
    
    func calculateResult(operand: String) {
        if enteredDigits != "" && !numberStack.isEmpty {
            let stackOp = operandStack.last
            if !((stackOp == "+" || stackOp == "-") && (operand == "*" || operand == "/")) {
                let currentOperand = operations[operandStack.removeLast()]
                result = currentOperand!(numberStack.removeLast(), result)
                doOperandEqual()
            }
        }
        operandStack.append(operand)
        numberStack.append(result)
        enteredDigits = ""
        updateNumberField()
    }
    
    func doOperandEqual() {
        if enteredDigits == "" {
            return
        }
        if !numberStack.isEmpty {
            let currentOperand = operations[operandStack.removeLast()]
            result = currentOperand!(numberStack.removeLast(), result)
            if !operandStack.isEmpty {
                doOperandEqual()
            }
        }
        updateNumberField()
        enteredDigits = ""
    }
    
    // UI Set-up

    @IBAction func btn0Press(sender: UIButton) {
        parseDigit("0")
    }
    @IBAction func btn1Press(sender: UIButton) {
        parseDigit("1")
    }
    @IBAction func btn2Press(sender: UIButton) {
        parseDigit("2")
    }
    @IBAction func btn3Press(sender: UIButton) {
        parseDigit("3")
    }
    @IBAction func btn4Press(sender: UIButton) {
        parseDigit("4")
    }
    @IBAction func btn5Press(sender: UIButton) {
        parseDigit("5")
    }
    @IBAction func btn6Press(sender: UIButton) {
        parseDigit("6")
    }
    @IBAction func btn7Press(sender: UIButton) {
        parseDigit("7")
    }
    @IBAction func btn8Press(sender: UIButton) {
        parseDigit("8")
    }
    @IBAction func btn9Press(sender: UIButton) {
        parseDigit("9")
    }
    
    @IBAction func btnDecPress(sender: UIButton) {
        if hasIndex(stringToSearch: enteredDigits, characterToFind: ".") == false {
            parseDigit(".")
        }
    }
    
    @IBAction func btnCHSPress(sender: UIButton) {
        if enteredDigits.isEmpty {
            if let _ = numberField.text {
                enteredDigits = numberField.text!
            }
        }
        parseDigit("-")
    }
    
    @IBAction func btnACPress(sender: UIButton) {
        operandStack.removeAll()
        numberStack.removeAll()
        
        enteredDigits = ""
        result = 0
        updateNumberField()
    }
    
    @IBAction func btnPlusPress(sender: UIButton) {
        calculateResult("+")
    }
    
    @IBAction func btnMinusPress(sender: UIButton) {
        calculateResult("-")
    }
    
    @IBAction func btnMultiplyPress(sender: UIButton) {
        calculateResult("*")
    }
    
    @IBAction func btnDividePress(sender: UIButton) {
        calculateResult("/")
    }
    
    @IBAction func btnEqualsPress(sender: UIButton) {
        doOperandEqual()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

