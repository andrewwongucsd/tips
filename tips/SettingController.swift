//
//  SetttingView.swift
//  tips
//
//  Created by Andrew on 12/31/14.
//  Copyright (c) 2014 Andrew. All rights reserved.
//

import Foundation
import UIKit

class SettingController: UIViewController{
    
    @IBOutlet weak var lock: UISwitch!
    @IBOutlet weak var left: UITextField!
    @IBOutlet weak var middle: UITextField!
    @IBOutlet weak var right: UITextField!
    
    
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
//            var red = defaults.integerForKey("red")
//            var green = defaults.integerForKey("green")
//            var blue = defaults.integerForKey("blue")
//            redBar.value = Float(red)
//            greenBar.value = Float(green)
//            blueBar.value = Float(blue)
            
        }else{
//            redBar.value = Float(arc4random_uniform(255))
//            greenBar.value = Float(arc4random_uniform(255))
//            blueBar.value = Float(arc4random_uniform(255))
            
        }
//        colorUpdate()

    }
}
