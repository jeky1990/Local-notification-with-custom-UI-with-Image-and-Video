//
//  NotificationViewController.swift
//  UInotification
//
//  Created by macbook on 10/31/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI
import AVKit
import AVFoundation


class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet var label: UILabel?
    @IBOutlet var label2: UILabel?

    @IBOutlet weak var imageview: UIView!
    
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet var Mainview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageview.isUserInteractionEnabled = false
        Mainview.isUserInteractionEnabled = false
        img1.isUserInteractionEnabled = false
        label?.isUserInteractionEnabled = false
        label2?.isUserInteractionEnabled = false
        
    }
    
    func didReceive(_ notification: UNNotification) {
        
        let bestAttemptContent = (notification.request.content.mutableCopy() as? UNMutableNotificationContent)

        if let bestAttemptContent1 = bestAttemptContent {
        
        print("Extension received notification.")
        print(notification)
        
        if notification.request.identifier == "local"
        {
        self.label?.text = notification.request.content.title
        self.label2?.text = notification.request.content.body
        
        // Image Attcahmnet Extraction
        let attachmentimage = bestAttemptContent1.attachments[1]
        let attachmnetImageurl = attachmentimage.url
            
            do{
                let data = try Data(contentsOf: attachmnetImageurl)
                
                self.img1.image = UIImage(data: data)
                
            }catch{}
            
        //video attachment Extraction
        let attachment = bestAttemptContent1.attachments[0]
            
        let attachmentURl = attachment.url
            
            // create a player for showing video
            let player = AVPlayer(url: attachmentURl)
            let playercontroller = AVPlayerViewController()
            playercontroller.player = player
            
            //create a player layer and add in specific view
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = self.imageview.bounds
            self.imageview.layer.addSublayer(playerLayer)
            player.play()
            
            // for presenting video in UI of notification
            
//            present(playercontroller, animated: true) {
//                playercontroller.player?.play()
//            }
            }
        
        }

        
    }

}
