//
//  Calculator.swift
//  Calculator
//
//  Created by hbd on 2022/10/1.
//

import UIKit


class Calculator: NSObject {
    
    
    enum Operator: Int {
        case ADD, SUB, MUL, DIV, PCT, NEG, NUM, POS, POW
    }
    
    struct Element {
        var type: Operator
        var value: Double
    }
    
    var levels = [Operator.ADD: 4, Operator.SUB: 4, Operator.MUL: 3, Operator.DIV: 3, Operator.POW: 2, Operator.NEG: 1, Operator.PCT: 1, Operator.POS: 1]
    var tokens: [Element] = []
    var justCalculated = false
    
    func eval(l: Int, r: Int, valid: inout Bool) -> Double {
        if l > r {
            valid = false
            return 1
        } else if l == r {
            if tokens[l].type == Operator.NUM {
                return tokens[l].value
            }
            valid = false
            return 1
        } else {
            var pos = l, level = 0
            for index in l...r {
                if levels.keys.contains(tokens[index].type) {
                    if levels[tokens[index].type]! >= level {
                        pos = index
                        level = levels[tokens[index].type]!
                    }
                }
            }
            switch tokens[pos].type {
            case Operator.ADD:
                return eval(l: l, r: pos - 1, valid: &valid) + eval(l: pos + 1, r: r, valid: &valid)
            case Operator.SUB:
                return eval(l: l, r: pos - 1, valid: &valid) - eval(l: pos + 1, r: r, valid: &valid)
            case Operator.MUL:
                return eval(l: l, r: pos - 1, valid: &valid) * eval(l: pos + 1, r: r, valid: &valid)
            case Operator.DIV:
                let part1: Double = eval(l: l, r: pos - 1, valid: &valid), part2: Double = eval(l: pos + 1, r: r, valid: &valid)
                if part2 == 0 {
                    valid = false
                    return 1
                }
                return part1 / part2
            case Operator.PCT:
                return eval(l: l, r: pos - 1, valid: &valid) / 100
            case Operator.NEG:
                return -eval(l: pos + 1, r: r, valid: &valid)
            case Operator.POW:
                let part1 = eval(l: l, r: pos - 1, valid: &valid)
                let part2 = pow(Double(10), eval(l: pos + 1, r: r, valid: &valid))
                let part3 = eval(l: pos + 1, r: r, valid: &valid)
                print("part3 = \(part3)")
                return part1 * part2
            case Operator.POS:
                return eval(l: pos + 1, r: r, valid: &valid)
            default:
                return 1
            }
        }
    }
    
    func expr(s: String, valid: inout Bool) -> Double {
        print("???")
        let len = s.count
        var i = 0
        print("s.count = \(len)")
        while i < len {
            if (s[s.index(s.startIndex, offsetBy: i)] >= "0" && s[s.index(s.startIndex, offsetBy: i)] <= "9") || s[s.index(s.startIndex, offsetBy: i)] == "." {
                var j = i
                var content: String = ""
                print("here")
                while j < len && ((s[s.index(s.startIndex, offsetBy: j)] >= "0" && s[s.index(s.startIndex, offsetBy: j)] <= "9") || s[s.index(s.startIndex, offsetBy: j)] == ".") {
                    content.append(s[s.index(s.startIndex, offsetBy: j)])
                    j += 1
                }
                if content ==  "." {
                    valid = false
                    tokens.append(Element(type: Operator.NUM, value: 1))
                }
                else {
                    tokens.append(Element(type: Operator.NUM, value: Double(content)!))
                }
                i = j - 1
                print("(((")
            } else if s[s.index(s.startIndex, offsetBy: i)] == "e" {
                tokens.append(Element(type: Operator.POW, value: 0))
            } else if s[s.index(s.startIndex, offsetBy: i)] == "+" {
                tokens.append(Element(type: Operator.ADD, value: 0))
            } else if s[s.index(s.startIndex, offsetBy: i)] == "−" || s[s.index(s.startIndex, offsetBy: i)] == "-" {
                tokens.append(Element(type: Operator.SUB, value: 0))
            } else if s[s.index(s.startIndex, offsetBy: i)] == "×" {
                tokens.append(Element(type: Operator.MUL, value: 0))
            } else if s[s.index(s.startIndex, offsetBy: i)] == "÷" {
                tokens.append(Element(type: Operator.DIV, value: 0))
            } else if s[s.index(s.startIndex, offsetBy: i)] == "%" {
                tokens.append(Element(type: Operator.PCT, value: 0))
            }
            i += 1
        }
        
        i = 0
        
         while i < tokens.count {
            if tokens[i].type == Operator.SUB && (i == 0 || (tokens[i - 1].type != Operator.NUM && tokens[i - 1].type != Operator.PCT)) {
                tokens[i].type = Operator.NEG
            }
            i += 1
        }
        
        i = 0
        
         while i < tokens.count {
            if tokens[i].type == Operator.ADD && (i == 0 || (tokens[i - 1].type != Operator.NUM && tokens[i - 1].type != Operator.PCT)) {
                tokens[i].type = Operator.POS
            }
            i += 1
        }
        
        print("tokens.count = \(tokens.count)")
        
        while tokens[tokens.count - 1].type != Operator.NUM && tokens[tokens.count - 1].type != Operator.PCT {
            var _ = tokens.popLast()
        }
        
        let result = eval(l: 0, r: tokens.count - 1, valid: &valid)
        tokens = []
        return result
    }
    
    func generateOutput(input: String) ->String {
        var output = ""
        if !input.isEmpty {
            var valid = true
            print("___")
            print(input)
            var result = String(expr(s: input, valid: &valid))
            print("***")
            if valid {
                var hasDot = false
                for ch in result {
                    if ch == "." {
                        hasDot = true
                        break
                    }
                }
                
                var hasExp = false
                for ch in result {
                    if ch == "e" {
                        hasExp = true
                        break
                    }
                }
                
                if hasDot && !hasExp {
                    while result.last! == "0" {
                        _ = result.popLast()
                    }
                    if result.last! == "." {
                        _ = result.popLast()
                    }
                    output = result
                }
                else {
                    output = result
                }
            }
            else {
                output = "错误"
            }
        }
        return output
    }
     
    func modifyLabels(title: String, inputText: String, outputText: String) -> (input: String, output: String) {
        var input = inputText
        var output = outputText
        switch title {
        case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
            if(justCalculated)
            {
                input = ""
            }
            if input.last != "%" {
                if title == "0" {
                    if input.isEmpty || input.last != "0" {
                        input.append(title)
                    }
                    else if input.last == "0" {
                        var temp = input
                        while !temp.isEmpty && temp.last == "0" {
                            _ = temp.popLast()
                        }
                        if !temp.isEmpty && (temp.last!.isNumber || temp.last == ".") {
                            input.append(title)
                        }
                    }
                }
                else {
                    if input.isEmpty || input.last != "0" {
                        input.append(title)
                    }
                    else if input.last == "0" {
                        var temp = input
                        while !temp.isEmpty && temp.last == "0" {
                            _ = temp.popLast()
                        }
                        if !temp.isEmpty && (temp.last!.isNumber || temp.last == ".") {
                            input.append(title)
                        }
                        else
                        {
                            _ = input.popLast()
                            input.append(title)
                        }
                    }
                }
            }
        case "%":
            input.append(title)
        case "C":
            input = ""
            output = ""
        case ".":
            if input.isEmpty {
                input.append(title)
            }
            
            else if !input.isEmpty && !input.last!.isNumber {
                if input.last != "." {
                    input.append(title)
                }
            }
            
            else if !input.isEmpty && input.last!.isNumber {
                var temp = input
                while !temp.isEmpty && temp.last!.isNumber {
                    _ = temp.popLast()
                }
                if temp.isEmpty || temp.last! != "." {
                    input.append(title)
                }
            }
            //+ − × ÷
        case "+", "×", "÷":
            if !input.isEmpty {
                if input.last!.isNumber || input.last! == "." || input.last! == "%" {
                    input.append(title)
                }
                else if input.count >= 2 && ((input[input.index(input.endIndex, offsetBy: -2)] == "×" || input[input.index(input.endIndex, offsetBy: -2)] == "÷") && (input[input.index(input.endIndex, offsetBy: -1)] == "−")) {
                    var temp = input
                    _ = temp.popLast()
                    _ = temp.popLast()
                    
                    temp.append(title)
                    input = temp
                }
                else if input.last! == "+" || input.last! == "−" || input.last! == "×" || input.last! == "÷" {
                    _ = input.popLast()
                    input.append(title)
                }
            }
        case "−":
            if input.isEmpty {
                input.append(title)
            }
            else {
                if input.last!.isNumber || input.last! == "." || input.last! == "%" || input.last! == "×" || input.last! == "÷" {
                    input.append(title)
                }
                else if input.last! == "+" || input.last! == "−" {
                    _ = input.popLast()
                    input.append(title)
                }
            }
        case "⬅︎":
            if !input.isEmpty {
                _ = input.popLast()
            }
        case "=":
            if output != "错误" {
                input = output
                // output = ""
                justCalculated = true
            }
        default:
            print("enter default")
        }
        if(title != "=")
        {
            output = generateOutput(input: input)
            justCalculated = false
        }
        return (input, output)
    }
    
    
}

