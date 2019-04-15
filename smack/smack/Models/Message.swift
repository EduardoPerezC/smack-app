//
//  Message.swift
//  smack
//
//  Created by Eduardo Perez on 4/14/19.
//  Copyright © 2019 Eduardo Perez. All rights reserved.
//

import Foundation

struct Message{
    
    public private(set) var id : String
    public private(set) var messageBody : String
    public private(set) var userId : String
    public private(set) var channelId : String
    public private(set) var userName : String
    public private(set) var userAvatar : String
    public private(set) var userAvatarColor : String
    public private(set) var timeStamp : String
    
    init(forId Id : String, messageBody : String, userId : String, channelId : String, userName : String, userAvatar : String,userAvatarColor : String,  timeStamp : String){
        
        self.id = Id
        self.messageBody = messageBody
        self.userId = userId
        self.channelId = channelId
        self.userName = userName
        self.userAvatar = userAvatar
        self.userAvatarColor = userAvatarColor
        self.timeStamp = timeStamp
        
    }
    
    
}
