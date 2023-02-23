//
//  NotificationsManager.swift
//  WeatherApp
//
//  Created by Dara Adekore on 2023-02-21.
//

import Foundation
import UserNotifications

class NotificationManager {
    
    static let shared = NotificationManager()
    
    func requestAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if granted {
                print("Authorization granted")
            } else {
                print("Authorization denied")
            }
        }
    }
    
    func scheduleMorningNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Good morning!"
        content.body = "Take a look at your local weather!"
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 8
        dateComponents.minute = 0
        dateComponents.second = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "weatherNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error scheduling morning weather notification: \(error)")
            } else {
                print("Weather notification scheduled")
            }
        }
    }
}
