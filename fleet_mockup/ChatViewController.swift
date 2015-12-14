//
//  ChatViewController.swift
//  FleetApp
//
//  Created by Emily Greinwald on 11/22/15.
//  Copyright © 2015 CS407. All rights reserved.
//

import UIKit
import JSQMessagesViewController

class ChatViewController: JSQMessagesViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.senderId = loggedInUser!.username;
        self.senderDisplayName = loggedInUser!.firstName + " " + loggedInUser!.lastName;
        
        self.collectionView!.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero;
        self.inputToolbar!.contentView!.leftBarButtonItem = nil;
        self.collectionView!.reloadData();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!)
    {
        let fullText = self.senderDisplayName + ": " + text;
        let message = JSQMessage(senderId: self.senderId, displayName: self.senderDisplayName, text: fullText);
        trip!.messages += [message];
        
        self.finishSendingMessageAnimated(true);
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        let data = trip!.messages[indexPath.row]
        return data
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trip!.messages.count
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, didDeleteMessageAtIndexPath indexPath: NSIndexPath!) {
        trip!.messages.removeAtIndex(indexPath.row)
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        let data = trip!.messages[indexPath.row]
        
        let factory = JSQMessagesBubbleImageFactory();
        
        switch(data.senderId) {
        case self.senderId:
            let userVehicle = trip!.vehicleForUser(loggedInUser!);
            
            if(userVehicle != nil)
            {
                let outGoingBubble = factory.outgoingMessagesBubbleImageWithColor(userVehicle!.textColor);
                return outGoingBubble
            }
            else
            {
                let outGoingBubble = factory.outgoingMessagesBubbleImageWithColor(UIColor.lightGrayColor());
                return outGoingBubble
            }
        default:
            let otherUser = trip!.userForUsername(data.senderId);
            
            var otherUserVehicle: Vehicle?
            
            if(otherUser != nil)
            {
                otherUserVehicle = trip!.vehicleForUser(otherUser!);
            }
            
            if(otherUserVehicle != nil)
            {
                let incomingBubble = factory.incomingMessagesBubbleImageWithColor(otherUserVehicle!.textColor);
                return incomingBubble
            }
            else
            {
                let incomingBubble = factory.incomingMessagesBubbleImageWithColor(UIColor.darkGrayColor());
                return incomingBubble
            }
        }
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForCellTopLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString!
    {
        //Date Label every 3rd Message
        if(indexPath.row % 3 == 0)
        {
            let message = trip!.messages[indexPath.item];
            return JSQMessagesTimestampFormatter().attributedTimestampForDate(message.date);
        }
        return nil;
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString!
    {
        //Name Label every Message
        let message = trip!.messages[indexPath.item];
        
        if(message.senderId == self.senderId)
        {
            return nil;
        }
        
        if(indexPath.row - 1 > 0)
        {
            let prevMessage = trip!.messages[indexPath.row-1];
            
            if(prevMessage.senderId == message.senderId)
            {
                return nil;
            }
        }
        
        return NSAttributedString(string: message.senderDisplayName);
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath) as! JSQMessagesCollectionViewCell;
        
        cell.textView?.dataDetectorTypes = UIDataDetectorTypes.None;
        return cell;  
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource!
    {
        return nil;
    }
}
