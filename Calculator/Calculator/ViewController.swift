//
//  ViewController.swift
//  Calculator
//
//  Created by hbd on 2022/10/1.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var sevenButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var percentButton: UIButton!
    
    @IBOutlet weak var divideButton: UIButton!
    @IBOutlet weak var eightButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var zeroButton: UIButton!
    
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var nineButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var dotButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var equalButton: UIButton!
    
    
    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var outputLabel: UILabel!
    
    var calculator = Calculator()
    
    //var states = ["empty": true, "inputingFloat": false, "addTyped": false, "subTyped": false, "mulTyped": false, "divTyped": false, "div/mul-subTyped": false]
    
    /*struct Event {
        var change: String
        var to: Bool
    }*/
    
    //var events: [[String: Bool]] = []
    
    var input: String = "", output: String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //exprssionText.textContainer.maximumNumberOfLines = 1
        modifyCorner()
    }
    
    func modifyCorner() {
        clearButton.layer.cornerRadius = clearButton.frame.size.height / 2
        sevenButton.layer.cornerRadius = sevenButton.frame.size.height / 2
        fourButton.layer.cornerRadius = fourButton.frame.size.height / 2
        oneButton.layer.cornerRadius = oneButton.frame.size.height / 2
        percentButton.layer.cornerRadius = percentButton.frame.size.height / 2
        divideButton.layer.cornerRadius = divideButton.frame.size.height / 2
        eightButton.layer.cornerRadius = eightButton.frame.size.height / 2
        fiveButton.layer.cornerRadius = fiveButton.frame.size.height / 2
        twoButton.layer.cornerRadius = twoButton.frame.size.height / 2
        zeroButton.layer.cornerRadius = zeroButton.bounds.size.height / 2
        multiplyButton.layer.cornerRadius = multiplyButton.frame.size.height / 2
        nineButton.layer.cornerRadius = nineButton.frame.size.height / 2
        sixButton.layer.cornerRadius = sixButton.frame.size.height / 2
        threeButton.layer.cornerRadius = threeButton.frame.size.height / 2
        dotButton.layer.cornerRadius = dotButton.frame.size.height / 2
        backButton.layer.cornerRadius = backButton.frame.size.height / 2
        minusButton.layer.cornerRadius = minusButton.frame.size.height / 2
        addButton.layer.cornerRadius = addButton.frame.size.height / 2
        equalButton.layer.cornerRadius = addButton.frame.size.height / 2
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { _ in
            self.modifyCorner()
        }
    }
    
    @IBAction func buttonDidClick(sender: UIButton) {
        let results = calculator.modifyLabels(title: sender.currentTitle!, inputText: input, outputText: output)
        input = results.input
        output = results.output
        inputLabel.attributedText = NSAttributedString(string: input)
        outputLabel.attributedText = NSAttributedString(string: output)
    }

}

