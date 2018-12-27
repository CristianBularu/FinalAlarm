//
//  AlarmTableViewCell.swift
//  FinalAlarm
//
//  Created by Cristian on 12/20/18.
//  Copyright © 2018 notACompany. All rights reserved.
//
import RealmSwift
import UIKit

class AlarmTableViewCell: UITableViewCell {

    @IBOutlet weak var TimeHM: UILabel!
    @IBOutlet weak var TimeMeridian: UILabel!
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var IsOn: UISwitch!
    var alarmUuid: String! = nil
    
    @IBAction func didSwitch(_ sender: UISwitch) {
        try! Realm().write {
            let item = try! Realm().objects(Alarm.self).filter("id = '\(alarmUuid!)'").first
            item?.isOn = sender.isOn
            if sender.isOn {
                addNotif(alarm: item!)
            }else {
                removeNotif(alarm: item!)
            }
        }
    }
    
    private func addNotif(alarm: Alarm){
        
    }
    private func removeNotif(alarm: Alarm){
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
