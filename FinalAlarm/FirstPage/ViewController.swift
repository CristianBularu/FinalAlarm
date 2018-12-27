//
//  ViewController.swift
//  FinalAlarm
//
//  Created by Cristian on 12/17/18.
//  Copyright © 2018 notACompany. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications

class ViewController: UIViewController {
    
    @IBOutlet weak var alarmsTable: UITableView!
    
    var alarms = [Alarm]()
    var systemNotifications = [UNNotificationRequest]()
 
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let realm = try! Realm()
        refreshActiveNotifications()
        alarms = Array(realm.objects(Alarm.self))
        alarmsTable.reloadData()
        self.alarmsTable.tableFooterView = UIView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.alarmsTable.allowsSelectionDuringEditing = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(viewWillAppear), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        UNUserNotificationCenter.current().requestAuthorization(options:
        [.sound, .alert, .badge]) { (didAllow, error) in
            if error == nil {
                //print("Allowed")
            }
        }
        alarmsTable.reloadData()
    }
    
    @IBAction func AddButton(_ sender: UIBarButtonItem) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddEdit") as? AddEditViewController {
            if let navigator = navigationController {
                viewController.newAlarm = true
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
    @IBAction func editBtn(_ sender: UIBarButtonItem) {
        self.alarmsTable.setEditing(!self.alarmsTable.isEditing, animated: true)
        sender.title = (self.alarmsTable.isEditing) ? "Done" : "Edit"
    }
    
    func refreshActiveNotifications(){
        let dispatchGr = DispatchGroup()
        systemNotifications = [UNNotificationRequest]()
        dispatchGr.enter()
        
        let center = UNUserNotificationCenter.current()
        center.getPendingNotificationRequests(completionHandler: { requests in
            for item in requests {
                self.systemNotifications.append(item)
            }
            dispatchGr.leave()
        })
        dispatchGr.notify(queue: .main) {
            return
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
    }
}



