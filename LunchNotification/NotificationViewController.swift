//
//  NotificationViewController.swift
//  LunchNotification
//
//  Created by macbook on 11/1/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet var label: UILabel?
    @IBOutlet var label1: UILabel?
    @IBOutlet weak var imageview: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func didReceive(_ notification: UNNotification) {
        
        let bca = notification.request.content.mutableCopy() as? UNMutableNotificationContent
        
        if let bca1 = bca{
            
            if bca1.categoryIdentifier == "Lunch"
            {
                self.label?.text = bca1.title
                self.label1?.text = bca1.body
                
                let ImageAttachment = bca1.attachments[0]
                let ImageAttachmentURL = ImageAttachment.url
                
                do
                {
                    let data = try Data(contentsOf: ImageAttachmentURL)
                    imageview.image = UIImage(data: data)
        
                } catch{}
            }
        
        }
    }

}
