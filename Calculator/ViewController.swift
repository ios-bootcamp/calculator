//
//  ViewController.swift
//  Calculator
//
//  Created by student12 on 2/12/19.
//  Copyright © 2019 pedro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var result: String! = nil
    var currentInput: String = ""
    var currentExpression: String = ""
    var operationStory: [String] = []
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet var numberButton: [UIButton]!
    @IBOutlet var operationButton: [UIButton]!
    
    @IBAction func numberPressed(_ sender: UIButton) {
        let number = sender.title(for: .normal)!
        
        validateInput(input: number)
    }
    
    @IBAction func operationPressed(_ sender: UIButton) {
        let operation = sender.title(for: .normal)!
        
        if operation != "Del" {
            currentExpression += " \(operation) "
        } else {
            currentInput = String(currentInput.dropLast())
            currentExpression = String(currentExpression.dropLast())
        }
        
        resultLabel.text = currentExpression
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func validateInput(input: String) {
        switch input {
            case "=":
                if currentExpression != "" {
                    operationStory.append(currentExpression)
                    resultLabel.text = result
                    currentExpression = result
                }
            case ".":
                if !currentInput.contains(".") {
                    currentInput += input
                    currentExpression += input
                }
            default:
                currentInput += input
                currentExpression += input
                result = CrazyMath.evaluate(expression: currentExpression)
        }
            
        resultLabel.text = currentExpression
    }
}

