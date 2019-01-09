//
//  AddEditTableViewExtension.swift
//  FinalAlarm
//
//  Created by Cristian on 12/27/18.
//  Copyright © 2018 notACompany. All rights reserved.
//

import UIKit

extension AddEditViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moreSettings", for: indexPath) //as! AlarmTableViewCell
        switch indexPath.row {
        case 0:
            let repeatCell = cell.viewWithTag(1) as! UILabel
            repeatCell.text = "Repeat"
            
            let array = Array(localAlarm!.repeatDays)
            let repeatValue = cell.viewWithTag(2) as! UILabel
            repeatValue.text = getShortRepeatDays(array: array)
            return cell
        case 1:
            let label = cell.viewWithTag(1) as! UILabel
            label.text = "Label"
            
            let labelValue = cell.viewWithTag(2) as! UILabel
            labelValue.text = localAlarm!.label
            return cell
        case 2:
            let soundCell = cell.viewWithTag(1) as! UILabel
            soundCell.text = "Sound"
            
            let soundValue = cell.viewWithTag(2) as! UILabel
            soundValue.text = soundsDictionary[localAlarm.songName]!.rawValue
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
}
