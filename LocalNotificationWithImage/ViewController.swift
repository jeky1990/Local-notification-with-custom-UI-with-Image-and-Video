//
//  ViewController.swift
//  LocalNotificationWithImage
//
//  Created by macbook on 10/30/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController,UNUserNotificationCenterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestPermissionsWithCompletionHandler(completion: nil)
        StartNotification()
        setupanotheNotification()
        
    }
    
    private func requestPermissionsWithCompletionHandler(completion: ((Bool) -> (Void))? ) {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert]) {[weak self] (granted, error) in
            
            guard error == nil else {
                
                completion?(false)
                return
            }
            
            if granted {
                
                UNUserNotificationCenter.current().delegate = self
                self?.setNotificationCategories()
            }
            
            completion?(granted)
        }
    }
    
    private func setNotificationCategories()
    {
        let likeAction = UNNotificationAction(identifier: "like", title: "Like", options: [])
        let notlikeAction = UNNotificationAction(identifier: "notlike", title: "Not Like", options: [])
        let replyAction = UNNotificationAction(identifier: "reply", title: "Reply", options: [])
        let archiveAction = UNNotificationAction(identifier: "archive", title: "Archive", options: [])
        let ccommentAction = UNTextInputNotificationAction(identifier: "comment", title: "Comment", options: [])
        let okAction = UNNotificationAction(identifier: "ok", title: "Ok", options: [])
        let ThankYouAction = UNNotificationAction(identifier: "thankuou", title: "Thank You", options: [])
        
        let LunchCat = UNNotificationCategory(identifier: "Lunch", actions: [okAction,ThankYouAction], intentIdentifiers: [], options: [])
        let localCat =  UNNotificationCategory(identifier: "category", actions: [likeAction,notlikeAction], intentIdentifiers: [], options: [])
        
        let customCat =  UNNotificationCategory(identifier: "recipe", actions: [likeAction,ccommentAction], intentIdentifiers: [], options: [])
        
        let emailCat =  UNNotificationCategory(identifier: "email", actions: [replyAction, archiveAction], intentIdentifiers: [], options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([localCat, customCat, emailCat,LunchCat])

    }
    
    func StartNotification()
    {
        
        let content = UNMutableNotificationContent()
        content.title = "Good Morning"
        content.body =  "Hello User!! Hope Your day is going good."

        content.categoryIdentifier = "category"

        let urlimage = Bundle.main.url(forResource: "gm", withExtension: "jpg")
        
        let video = Bundle.main.url(forResource: "sample", withExtension: "mp4")
    
        let attachment = try! UNNotificationAttachment(identifier: "image", url: urlimage!, options: [:])
        let attachmentVideo = try! UNNotificationAttachment(identifier: "video", url: video!, options: [:])
        
        
        content.attachments = [attachmentVideo,attachment]

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
    
        let request = UNNotificationRequest(identifier: "local", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { (error) in
            print(error?.localizedDescription as Any)
          }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if response.actionIdentifier == "like"
        {
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "ThirdViewController")
            self.navigationController?.pushViewController(nav!, animated: true)
        }
        else if response.actionIdentifier == "notlike"
        {
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController")
            self.navigationController?.pushViewController(nav!, animated: true)
        }
        
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .sound, .badge])
    }
    
    func setupanotheNotification()
    {
        //Set Content for Notification
        let content = UNMutableNotificationContent()
        content.title = "Good Afternoon"
        content.body = "It's Time to Lunch."
        content.categoryIdentifier = "Lunch"
        
        //create attachment
        let attachmentURl = Bundle.main.url(forResource: "lunch", withExtension: "jpg")
        let imageAttachment = try! UNNotificationAttachment(identifier: "image", url: attachmentURl!, options: [:])
        content.attachments = [imageAttachment]
        
        // Set Time for daily notification at lunch time
        let indian = Calendar(identifier: .indian)
        let now = Date()
        var dateComponents = indian.dateComponents([.year,.month,.day,.hour,.minute,.second], from: now)
        dateComponents.hour = 13
        dateComponents.minute = 00
        dateComponents.second = 00
        let date = indian.date(from: dateComponents)!
        
        //create trigger to add time
        let triggerdaily = Calendar.current.dateComponents([.hour,.minute,.second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerdaily, repeats: true)
        
        //Create request
        let request = UNNotificationRequest(identifier: "second", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            print(error?.localizedDescription as Any)
        }
    }
}




