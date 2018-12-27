//
//  LabelViewController.swift
//  FinalAlarm
//
//  Created by Cristian on 12/19/18.
//  Copyright © 2018 notACompany. All rights reserved.
//
import UIKit

class LabelViewController: UIViewController {

    @IBOutlet weak var editLabel: UITextField!

    var alarm: Alarm! = nil
    
    @IBAction func didEdit(_ sender: UITextField) {
        if sender.text?.isEmpty ?? true {
            alarm.label = "Alarm"
        }else{
            alarm.label = sender.text!
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editLabel.text = alarm.label
    }
}
