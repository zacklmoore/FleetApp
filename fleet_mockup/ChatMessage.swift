//
//  ChatMessage.swift
//  FleetApp
//
//  Created by Zackary Moore on 12/12/15.
//  Copyright © 2015 CS407. All rights reserved.
//

import UIKit

class ChatMessage{
    var sender: User
    var message: String
    var color: UIColor
    var icon: UIImage?
    
    enum messageType {
        case chat, event
    }
    
    init(send: User, msg: String, clr: UIColor)
    {
        self.sender = send;
        self.message = msg;
        self.color = clr;
    }
}