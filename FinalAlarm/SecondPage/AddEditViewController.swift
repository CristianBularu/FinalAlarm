//
//  AddEditViewController.swift
//  FinalAlarm
//
//  Created by Cristian on 12/18/18.
//  Copyright © 2018 notACompany. All rights reserved.
//
import RealmSwift
import UIKit

class AddEditViewController: UIViewController{
    
    @IBOutlet weak var optionsTable: UITableView!
    @IBOutlet weak var DatePickerOutlet: UIDatePicker!
    
    var newAlarm: Bool?
    var alarmUuid: String? = nil
    var localAlarm: Alarm! = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.optionsTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.DatePickerOutlet.setValue(UIColor.white, forKey: "textColor")
        self.DatePickerOutlet.setValue(true, forKey: "highlightsToday")
        
        
        if newAlarm ?? false {
            localAlarm = Alarm()
        } else {
            let realm = try! Realm()
            let alarm = realm.objects(Alarm.self).filter("Id = '\(alarmUuid ?? "")'").first
            if alarm != nil {
                localAlarm = Alarm()
                localAlarm!.Id = alarm!.Id
                localAlarm!.isOn = alarm!.isOn
                localAlarm!.time = alarm!.time
                localAlarm!.label = alarm!.label
                localAlarm.repeatDays.removeAll()
                for day in alarm!.repeatDays {
                    localAlarm.repeatDays.append(day)
                }
                localAlarm.songName = alarm!.songName
            }else {
                localAlarm = Alarm()
                alarmUuid = localAlarm.Id
                newAlarm = true
            }
        }
        self.DatePickerOutlet.date = localAlarm.time
    }
    
    @IBAction func CancelButton(_ sender: UIBarButtonItem) {
        alarmUuid = nil
        localAlarm = nil
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func SaveButton(_ sender: UIBarButtonItem) {
        
        let realm = try! Realm()
        let alarm = realm.objects(Alarm.self).filter("Id = '\(alarmUuid ?? "")'").first
        
        localAlarm!.time = DatePickerOutlet.date
        
        if alarm != nil {
            removeAlarm(alarm: alarm!)//remove the old alarm/s if exists
        }
        addAlarm(alarm: localAlarm)//add the new alarm/s
        
        if !(newAlarm ?? true) {//if the alarm iis not new
            
            try! realm.write {
                
                if alarm != nil {//update the entity from realm
                    alarm!.Id = localAlarm!.Id
                    alarm!.isOn = localAlarm!.isOn
                    alarm!.time = localAlarm!.time
                    alarm!.label = localAlarm!.label
                    alarm!.repeatDays.removeAll()
                    for day in localAlarm!.repeatDays {
                        alarm!.repeatDays.append(day)
                    }
                    alarm!.songName = localAlarm!.songName
                }
            }
        } else {
            try! realm.write {
                realm.add(localAlarm)//add entitty to realm
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
}






