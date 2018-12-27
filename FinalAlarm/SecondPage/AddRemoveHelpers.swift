//
//  AddRemoveHelpers.swift
//  FinalAlarm
//
//  Created by Cristian on 12/27/18.
//  Copyright © 2018 notACompany. All rights reserved.
//
import UserNotifications

func addAlarm(alarm: Alarm){
    
    var components = DateComponents()
    components.hour = Calendar.current.component(.hour, from: alarm.time)
    components.minute = Calendar.current.component(.minute, from: alarm.time)
    
    let content = UNMutableNotificationContent()
    content.title = "Alarm"
    content.body = alarm.label
    content.sound = UNNotificationSound.init(named: UNNotificationSoundName(rawValue: "\(soundsDictionary[alarm.songName]?.rawValue ?? "").mp3"))
    
    if alarm.repeatDays.count == 0 {
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: alarm.Id, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if error == nil {
                //print("Notifi added")
            }
        }
    } else {
        for dayNumber in alarm.repeatDays {
            let weekDay = dayNumber + 2
            if weekDay > 7 {
                components.weekday = 1
            } else {
                components.weekday = weekDay
            }
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
            let request = UNNotificationRequest(identifier: "\(dayNumber)+\(alarm.Id)", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { (error) in
                if error == nil {
                    //print("Recur Notifi added")
                }
            }
        }
    }
}

func removeAlarm(alarm: Alarm){
    if alarm.repeatDays.count == 0 {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.Id])
    }else {
        var list = [String]()
        for dayNumber in alarm.repeatDays {
            list.append("\(dayNumber)+\(alarm.Id)")
        }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: list)
    }
}

func getShortRepeatDays(array: [Int]) -> String{
    if array.count == 0 {
        return "Never"
    } else if array.count == 7{
        return "Every Day"
    } else if array.count == 1 {
        return "Every \(daysDictionary[array.first!]!.rawValue)"
    } else if array.count == 2 && array.contains(5) && array.contains(6) {
        return "Every Weekend "
    } else if array.count == 5 && !array.contains(5) && !array.contains(6) {
        return "Every Weekday"
    } else {
        var finalString: String! = nil
        for day in array {
            let code = daysDictionary[day]!.rawValue
            let first3 = code.substring(to: code.index(code.startIndex, offsetBy: 3))
            
            if finalString != nil {
                finalString.append(" ")
            } else {
                finalString = ""
            }
            finalString.append(first3)
        }
        return finalString
    }
}
