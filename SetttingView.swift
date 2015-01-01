//
//  SetttingView.swift
//  tips
//
//  Created by Andrew on 12/31/14.
//  Copyright (c) 2014 Andrew. All rights reserved.
//

import Foundation
import UIKit

class SettingViewController: UIViewController{
    @IBOutlet weak var colorLockLabel: UILabel!
    @IBOutlet weak var redBar: UISlider!
    @IBOutlet weak var greenBar: UISlider!
    @IBOutlet weak var blueBar: UISlider!
    @IBOutlet weak var left: UITextField!
    @IBOutlet weak var middle: UITextField!
    @IBOutlet weak var right: UITextField!
    @IBOutlet weak var defaultTipLabel: UILabel!
    @IBOutlet weak var colorbgLabel: UILabel!
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    @IBOutlet weak var closingLabel: UILabel!
    @IBOutlet weak var lock: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        var defaults = NSUserDefaults.standardUserDefaults()
        var leftValue = defaults.integerForKey("left")
        var middleValue = defaults.integerForKey("middle")
        var rightValue = defaults.integerForKey("right")
        var isLock = defaults.boolForKey("locker")
        left.text = String(leftValue)
        middle.text = String(middleValue)
        right.text = String(rightValue)
        lock.setOn(isLock, animated: true)
        if(isLock){
            var red = defaults.integerForKey("red")
            var green = defaults.integerForKey("green")
            var blue = defaults.integerForKey("blue")
            redBar.value = Float(red)
            greenBar.value = Float(green)
            blueBar.value = Float(blue)
            lock.on = isLock
            setLock(false)
        }else{
            redBar.value = Float(arc4random_uniform(255))
            greenBar.value = Float(arc4random_uniform(255))
            blueBar.value = Float(arc4random_uniform(255))

        }
        colorUpdate()
        
    }
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    func setLock(input: Bool){
        self.redBar.enabled = input
        self.greenBar.enabled = input
        self.blueBar.enabled = input
    }
    
    @IBAction func lock(sender: UISwitch) {
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(sender.on , forKey: "locker")
        setLock(!sender.on)
        defaults.synchronize()
    }
  
    @IBAction func onEditingChanged(sender: AnyObject){
        dataChanging()
    }
    
    @IBAction func redSliderChaged(sender: UISlider){
        println(sender.value)
        colorUpdate()
    }
    @IBAction func greenSliderChaged(sender: UISlider){
        println(sender.value)
        colorUpdate()
    }
    @IBAction func blueSliderChaged(sender: UISlider){
        println(sender.value)
        colorUpdate()
    }
    func colorUpdate(){
        var defaults = NSUserDefaults.standardUserDefaults()
            let red = CGFloat(redBar.value)
            let blue = CGFloat(blueBar.value)
            let green = CGFloat(greenBar.value)
            redLabel.text = "\(Int(redBar.value))"
            greenLabel.text = "\(Int(greenBar.value))"
            blueLabel.text = "\(Int(blueBar.value))"
            defaults.setInteger(Int(redBar.value), forKey: "red")
            defaults.setInteger(Int(greenBar.value), forKey: "green")
            defaults.setInteger(Int(blueBar.value), forKey: "blue")
            defaults.synchronize()
            let redVal = red/255.0
            let blueVal = blue/255.0
            let greenVal = green/255.0
            println("\(red) \(blue) \(green)")
            let color = UIColor(red: redVal, green: greenVal, blue: blueVal, alpha: 1.0)
            self.view.backgroundColor = color
            if(Int(redBar.value) < 63 || Int(greenBar.value) < 63){
                let white = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                defaultTipLabel.textColor = white
                colorbgLabel.textColor = white
                redLabel.textColor = white
                greenLabel.textColor = white
                blueLabel.textColor = white
                closingLabel.textColor = white
                colorLockLabel.textColor = white
            }else{
                defaultTipLabel.textColor = UIColor.blackColor()
                colorbgLabel.textColor = UIColor.blackColor()
                redLabel.textColor = UIColor.blackColor()
                greenLabel.textColor = UIColor.blackColor()
                blueLabel.textColor = UIColor.blackColor()
                closingLabel.textColor = UIColor.blackColor()
                colorLockLabel.textColor = UIColor.blackColor()
        
            }
        
    }
    
    func dataChanging(){
        var defaults = NSUserDefaults.standardUserDefaults()
        var leftV = left.text.toInt()
        var middleV = middle.text.toInt()
        var rightV = right.text.toInt()
        var leftValue = 0
        var middleValue = 0
        var rightValue = 0
        if(leftV != nil){
            leftValue = leftV!
        }
        if(middleV != nil){
            middleValue = middleV!
        }
        if(rightV != nil){
            rightValue = rightV!
        }
        println("onEdit \(leftValue) \(middleValue) \(rightValue)")
        
        if(isValid(leftValue) && isValid(middleValue) && isValid(rightValue)){
            defaults.setInteger(leftValue, forKey: "left")
            defaults.setInteger(middleValue, forKey: "middle")
            defaults.setInteger(rightValue, forKey: "right")
            defaults.synchronize()
        }
    }
    
    func isValid(input: Int) -> Bool{
        if(input < 100 && input > 0){
            return true
        }
        return false
    }
    
}
