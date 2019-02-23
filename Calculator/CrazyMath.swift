//
//  crazyMath.swift
//  Calculator
//
//  Created by student12 on 2/23/19.
//  Copyright © 2019 pedro. All rights reserved.
//

import Foundation

class CrazyMath {
    static func evaluateLazy(expression: String) -> String! {
        let expr = NSExpression(format: expression)
        
        if let result = expr.expressionValue(with: nil, context: nil) as? Double {
            return String(result)
        } else {
            return nil
        }
    }
    
    static func evaluate(expression: String) -> String! {
        var exprTokenized = expression.split(separator: " ")
        
        if exprTokenized.first == "-" || exprTokenized.first == "+" {
            exprTokenized.insert("0", at: 0)
        }
        
        if let firstIndex = exprTokenized.lastIndex(of: "(") {
            var expression = ""
            
            if let lastIndex = exprTokenized.firstIndex(of: ")") {
                for i in firstIndex + 1..<lastIndex {
                    expression += " " + exprTokenized[i]
                }
                
                exprTokenized.removeSubrange(firstIndex...lastIndex)
                exprTokenized.insert(String.SubSequence(String(doMath(expression)!)), at: firstIndex)
                
                return evaluate(expression: exprTokenized.joined(separator: " "))
            }
        }
        
        if let index = exprTokenized.firstIndex(of: "/") {
            let res = String(doMath(String(exprTokenized[index - 1] + " / " + exprTokenized[index + 1]))!)
            
            exprTokenized.removeSubrange(index - 1...index + 1)
            exprTokenized.insert(String.SubSequence(res), at: index - 1)
            
            return evaluate(expression: exprTokenized.joined(separator: " "))
        }
        
        if let index = exprTokenized.firstIndex(of: "*") {
            let res = String(doMath(String(exprTokenized[index - 1] + " * " + exprTokenized[index + 1]))!)
            
            exprTokenized.removeSubrange(index - 1...index + 1)
            exprTokenized.insert(String.SubSequence(res), at: index - 1)
            
            return evaluate(expression: exprTokenized.joined(separator: " "))
        }
        
        if let index = exprTokenized.firstIndex(of: "+") {
            let res = String(doMath(String(exprTokenized[index - 1] + " + " + exprTokenized[index + 1]))!)
            
            exprTokenized.removeSubrange(index - 1...index + 1)
            exprTokenized.insert(String.SubSequence(res), at: index - 1)
            
            return evaluate(expression: exprTokenized.joined(separator: " "))
        }
        
        if let index = exprTokenized.firstIndex(of: "-") {
            let res = String(doMath(String(exprTokenized[index - 1] + " - " + exprTokenized[index + 1]))!)
            
            exprTokenized.removeSubrange(index - 1...index + 1)
            exprTokenized.insert(String.SubSequence(res), at: index - 1)
            
            return evaluate(expression: exprTokenized.joined(separator: " "))
        }
        
        return exprTokenized.joined(separator: " ")
    }
    
    static private func doMath(_ expression: String) -> Double? {
        let exprTokenized = expression.split(separator: " ")
        var result: Double? = nil
        var operand: String?
    
        for token in exprTokenized {
            if token != "+" && token != "-" && token != "*" && token != "/" {
                if result == nil {
                    if let firstNum = Double(token) {
                        result = firstNum
                    }
                } else {
                    switch operand {
                    case "+":
                        if let fNum = result {
                            if let secondNum = Double(token) {
                                result = fNum + secondNum
                            }
                        }
                    case "-":
                        if let fNum = result {
                            if let secondNum = Double(token) {
                                result = fNum - secondNum
                            }
                        }
                    case "*":
                        if let fNum = result {
                            if let secondNum = Double(token) {
                                result = fNum * secondNum
                            }
                        }
                    case "/":
                        if let fNum = result {
                            if let secondNum = Double(token) {
                                result = fNum / secondNum
                            }
                        }
                    default:
                        break
                    }
                }
            } else {
                operand = String(token)
            }
        }
    
        return result
    }
}
