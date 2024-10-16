//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Mohammad Jabbari on 9/13/24.
//

import Foundation

func changeDigitNumber(input: Double) -> Double{
    return -input
}
func percent(input1: Double, input2: Double) -> Double{
    return (input1 * input2) / 100
}
func erase(_ value: Double) -> Double{
    return 0
}

struct CalculatorBrain {
    var accumulator: Double?
    mutating func setOperand(_ operand: Double){
        accumulator = operand
    }
    var operations: [String: Operation] = [
        "+": Operation.binaryOperation( + ),
        "-": Operation.binaryOperation( - ),
        "✕": Operation.binaryOperation( * ),
        "÷": Operation.binaryOperation( / ),
        "=": Operation.result,
        "+/-": Operation.unaryOperation(changeDigitNumber),
        "AC": Operation.unaryOperation(erase),
        "%": Operation.binaryOperation(percent)
    ]
    mutating func setOperator(_ operation: String){
        if let operation = operations[operation]{
            switch operation {
            case .constant(let double):
                accumulator = double
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = Double(function(accumulator!))
                }
            case .binaryOperation(let function):
                if accumulator != nil {
                    st = Storage(firstOperand: accumulator!, function: function)
                }
            case .result:
                if st != nil && accumulator != nil{
                    accumulator = st?.result(secondOperand: accumulator!)
                }
            }
        }
        
    }
    var st: Storage?
    struct Storage {
        let firstOperand: Double
        let function: (Double, Double) -> Double
        func result(secondOperand: Double) -> Double?{
            return function(firstOperand, secondOperand)
        }
        
    }
    enum Operation {
        case constant(Double)
        case unaryOperation((Double)-> Double)
        case binaryOperation((Double, Double) -> Double)
        case result
    }
    var result: Double?{accumulator}
    
}
