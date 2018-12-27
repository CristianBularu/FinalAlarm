//
//  AlarmTableViewCell.swift
//  FinalAlarm
//
//  Created by Cristian on 12/27/18.
//  Copyright © 2018 notACompany. All rights reserved.
//

import UIKit
import RealmSwift

class AlarmTableViewCell: UITableViewCell {
    
    @IBOutlet weak var time1: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var switch4: UISwitch!
    
    var alarmUuid: String = "Empty"
    
    @IBAction func didChange(_ sender: UISwitch) {
        
        if let item = try! Realm().objects(Alarm.self).filter("Id = '\(alarmUuid)'").first{
            
            try! Realm().write {
                item.isOn = sender.isOn
            }
            
            if sender.isOn {
                addAlarm(alarm: item)
            }else {
                removeAlarm(alarm: item)
            }
        }
    }
}
