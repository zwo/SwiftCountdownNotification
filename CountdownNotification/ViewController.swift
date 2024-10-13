//
//  ViewController.swift
//  CountdownNotification
//
//  Created by 周维鸥 on 2024/10/12.
//
// ref: https://vikramios.medium.com/mastering-swift-local-notifications-a-developers-guide-f56b77ab64cc

import UIKit

class ViewController: UIViewController {
    
    let notificationIdentifier = "reminderNotification"
    let defaultStoredKey = "LastUsedTimeInterval"

    @IBOutlet weak var buttonSchedule: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        restoreLastUsedTimeInterval()
    }

    @IBAction func onButtonSchedule(_ sender: UIButton) {
        let interval = datePicker.countDownDuration
        Logger.print("Notification send after \(interval) seconds")
        cancelScheduledNotification()
        saveToDefaults(interval)
        scheduleNotification(interval)
    }
    
    @IBAction func onButtonCancel(_ sender: UIButton) {
        cancelScheduledNotification()
        showAlert("All notificaiton cancelled")
    }
    
    func scheduleNotification(_ interval: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "Time is up!"
//        content.sound = UNNotificationSound.default
        content.sound = UNNotificationSound(named: UNNotificationSoundName("go_to_sleep_alert.caf"))

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)

        let request = UNNotificationRequest(identifier: notificationIdentifier, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                Logger.print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self.showAlert("Notification scheduled successfully")
                }
            }
        }
    }
    
    func cancelScheduledNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    func showAlert(_ content: String) {
        let alertController = UIAlertController(title: "Warning", message: content, preferredStyle: .alert)
        
        // 创建确认按钮
        let confirmAction = UIAlertAction(title: "确认", style: .default) { _ in
            Logger.print("用户点击了确认")
        }
        
        alertController.addAction(confirmAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func saveToDefaults(_ interval: TimeInterval) {
        let defaults = UserDefaults.standard
        defaults.setValue(interval, forKey: defaultStoredKey)
    }
    
    func restoreLastUsedTimeInterval() {
        let defaults = UserDefaults.standard
        let interval: TimeInterval = defaults.double(forKey: defaultStoredKey)
        if interval > 0.9 {
            datePicker.countDownDuration = interval
        }
    }
    
}

