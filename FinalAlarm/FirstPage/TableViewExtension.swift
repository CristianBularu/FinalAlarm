//
//  TableViewExtension.swift
//  FinalAlarm
//
//  Created by Cristian on 12/27/18.
//  Copyright © 2018 notACompany. All rights reserved.
//

import UIKit
import RealmSwift

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarms.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let realm = try! Realm()
            try! realm.write {
                removeAlarm(alarm: alarms[indexPath.row])
                realm.delete(alarms[indexPath.row])
                alarms.remove(at: indexPath.row)
                tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.alarmsTable.isEditing {
            self.alarmsTable.isEditing = false
            self.navigationItem.leftBarButtonItem?.title = "Edit"
            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddEdit") as? AddEditViewController {
                if let navigator = navigationController {
                    viewController.newAlarm = false
                    viewController.alarmUuid = alarms[indexPath.row].Id
                    navigator.pushViewController(viewController, animated: true)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "baseAlarm", for: indexPath) as! AlarmTableViewCell
        
        let alarm = alarms[indexPath.row]
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "h:mm a"
        let timeDate = dateFormater.string(from: alarm.time)
        
        var isON: Bool? = nil
        
        print("Total Active notif found: \(systemNotifications.count)")
        if alarm.repeatDays.count == 0 {
            let alarmsFound = systemNotifications.filter{ $0.identifier == alarm.Id }.count
            if alarmsFound > 0 {
                isON = true
            }else{
                isON = false
            }
        }else {
            var totalAlarms = 0
            for dayNumber in alarm.repeatDays {
                let alarmsFound = systemNotifications.filter{ $0.identifier == "\(dayNumber)+\(alarm.Id)" }.count
                if alarmsFound > 0 {
                    totalAlarms += 1
                }
            }
            if totalAlarms == alarm.repeatDays.count {
                isON = true
            }else {
                isON = false
            }
        }
        cell.switch4.isOn = isON!
        cell.time1.text = "\(timeDate)"
        cell.label3.text = "\(alarm.label), \(getShortRepeatDays(array: Array(alarm.repeatDays)))"
        cell.alarmUuid = alarm.Id
        
        return cell
    }
}
