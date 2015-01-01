//
//  ViewController.swift
//  tips
//
//  Created by Andrew on 12/26/14.
//  Copyright (c) 2014 Andrew. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var perPersonStaticLabel: UILabel!
    @IBOutlet weak var totalStaticLabel: UILabel!
    @IBOutlet weak var tipStaticLabel: UILabel!
    @IBOutlet weak var billAmountStaticLabel: UILabel!
    @IBOutlet weak var barStaticLabel: UIView!
    @IBOutlet weak var personLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var perPersonLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        perPersonLabel.text = "$0.00"
        personLabel.text = "5"
        var defaults = NSUserDefaults.standardUserDefaults()
        
        if(defaults.integerForKey("used") == 0){
            tipControl.setTitle("15%", forSegmentAtIndex: 0)
            tipControl.setTitle("18%", forSegmentAtIndex: 1)
            tipControl.setTitle("20%", forSegmentAtIndex: 2)
            defaults.setInteger(15, forKey: "left")
            defaults.setInteger(18, forKey: "middle")
            defaults.setInteger(20, forKey: "right")
            defaults.setInteger(1, forKey: "used")
            defaults.synchronize()
        }else{
            
            calculate()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func calculate(){
        var defaults = NSUserDefaults.standardUserDefaults()
        var leftValue = defaults.integerForKey("left")
        var middleValue = defaults.integerForKey("middle")
        var rightValue = defaults.integerForKey("right")
        tipControl.setTitle(String(format: "%d%%",leftValue), forSegmentAtIndex: 0)
        tipControl.setTitle(String(format: "%d%%",middleValue), forSegmentAtIndex: 1)
        tipControl.setTitle(String(format: "%d%%",rightValue), forSegmentAtIndex: 2)
        let red = defaults.integerForKey("red")
        let green = defaults.integerForKey("green")
        let blue = defaults.integerForKey("blue")
        println("\(red) \(blue) \(green) in Calculate")
        var color = UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: CGFloat(1.0))
        self.view.backgroundColor = color
        if(red < 63 || green < 63){
            let white = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
            barStaticLabel.backgroundColor = white
            billAmountStaticLabel.textColor = white
            tipStaticLabel.textColor = white
            totalStaticLabel.textColor = white
            tipLabel.textColor = white
            totalLabel.textColor = white
            personLabel.textColor = white
            perPersonLabel.textColor = white
            perPersonStaticLabel.textColor = white
            
        }else{
            barStaticLabel.backgroundColor = UIColor.blackColor()
            billAmountStaticLabel.textColor = UIColor.blackColor()
            tipStaticLabel.textColor = UIColor.blackColor()
            totalStaticLabel.textColor = UIColor.blackColor()
            tipLabel.textColor = UIColor.blackColor()
            totalLabel.textColor = UIColor.blackColor()
            personLabel.textColor = UIColor.blackColor()
            perPersonLabel.textColor = UIColor.blackColor()
            perPersonStaticLabel.textColor = UIColor.blackColor()
        }


        
        if(billField.text.isEmpty != true){
            var defaults = NSUserDefaults.standardUserDefaults()
            var left = defaults.integerForKey("left")
            var middle = defaults.integerForKey("middle")
            var right = defaults.integerForKey("right")
            var tipPercentages = [left,middle, right]
            var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
            var tipConverted = Double(tipPercentage)
            println("\(left) \(middle) \(right) \(tipPercentage) \(tipConverted)")
            var billAmount = (billField.text as NSString).doubleValue
            var numberOfPerson = Int(slider.value)
            var tip = billAmount * tipConverted * 0.001
            var total = billAmount + tip
            var perPerson = total/Double(numberOfPerson)
            
            var formatter = NSNumberFormatter()
            formatter.numberStyle = .CurrencyStyle
            formatter.locale = NSLocale.currentLocale()
            //tipLabel.text = String(format: "$%.2f", tip)
            tipLabel.text = formatter.stringFromNumber(tip)
            //totalLabel.text = String(format: "$%.2f", total)
            totalLabel.text = formatter.stringFromNumber(total)
            //perPersonLabel.text = String(format: "$%.2f", perPerson)
            perPersonLabel.text = formatter.stringFromNumber(perPerson)
        }
    }
    

    @IBAction func onEditingChanged(sender: AnyObject) {

        calculate()

    }

    @IBAction func sliderValueChanged(sender: UISlider) {
        var currentValue = Int(sender.value)
        personLabel.text = "\(currentValue)"
    }
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        println("view will appear")

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        println("view did appear")

        
        calculate()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        println("view will disappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        println("view did disappear")
    }
}

