//
//  AlarmTableViewController.swift
//  FinalAlarm
//
//  Created by Cristian on 12/18/18.
//  Copyright © 2018 notACompany. All rights reserved.
//
import RealmSwift
import UIKit
import Foundation

class AlarmTableViewController: UITableViewController {

    private var alarms: [Alarm]! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = UIColor(named: "000000")
        alarms = Array(try! Realm().objects(Alarm.self))
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return alarms.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SingleAlarm", for: indexPath) as! AlarmTableViewCell
        
        let alarm = alarms[indexPath.row]

        let hour = Calendar.current.component(.hour, from: alarm.time)
        let minutes = Calendar.current.component(.minute, from: alarm.time)
        let cell3 = cell.viewWithTag(3) as! UILabel
        let cell4 = cell.viewWithTag(4) as! UILabel
        let cell5 = cell.viewWithTag(5) as! UILabel
        let cell6 = cell.viewWithTag(6) as! UISwitch
        
        cell3.text = "\(hour) : \(minutes)"
        cell4.text = "NO"
        cell5.text = alarm.label
        cell6.isOn = alarm.isOn
        cell.alarmUuid = alarm.Id
        
        return cell
    }

    @objc func switchChanged(_ sender : UISwitch!){
        
        
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
