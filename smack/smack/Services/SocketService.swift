//
//  SocketService.swift
//  smack
//
//  Created by Eduardo Perez on 4/7/19.
//  Copyright © 2019 Eduardo Perez. All rights reserved.
//

import Foundation
import SocketIO

class SocketService{
    
    public static let instance = SocketService()
    private let NEW_CHANNEL_EVENT = "newChannel"
    private let CHANNEL_CREATED_EVENT = "channelCreated"
    private let NEW_MESSAGE = "newMessage"
    private let MESSAGE_CREATED = "messageCreated"
    
    //constants properties can be assigned within a initializer
    private let manager : SocketManager
    private let socket : SocketIOClient
    
    private init(){
        
        manager = SocketManager(socketURL: URL(string: Constants.BASE_URL)!)
        socket = manager.defaultSocket
        
    }
    
    func addChannel(forName name : String, forDesc description : String, onComplete : @escaping Constants.CompletionHandler){
        
        socket.emit(NEW_CHANNEL_EVENT, name,description)
        onComplete(true)
        
        
    }
    
    func sendMessage(message : String, onComplete : @escaping Constants.CompletionHandler){
        
        guard let channelId = MessageService.instance.selectedChannel?.id else {return}
        
        socket.emit(NEW_MESSAGE, message, UserDataService.instance.id, channelId,UserDataService.instance.name, UserDataService.instance.avatarName, UserDataService.instance.avatarColor)
        onComplete(true)
        
    }
    
    func startIncomingMessageListener(onComplete :  @escaping Constants.CompletionHandler){
        
        socket.on(MESSAGE_CREATED) { (data, ack) in
            
            guard let messageBody = data[0] as? String else{ return}
            guard let userId = data[1] as? String else{ return}
            guard let channelId = data[2] as? String else{ return}
            guard let userName = data[3] as? String else{ return}
            guard let userAvatar = data[4] as? String else{ return}
            guard let userAvatarColor = data[5] as? String else{ return}
            guard let id = data[6] as? String else{ return}
            guard let timeStamp = data[7] as? String else{ return}
            
            let newMessage = Message(forId: id, messageBody: messageBody, userId: userId, channelId: channelId, userName: userName, userAvatar: userAvatar, userAvatarColor: userAvatarColor, timeStamp: timeStamp)
            
            MessageService.instance.appendMessage(newMessage: newMessage)
            onComplete(true)
            
        }
    }
    
    
    //this is going to be behave as a listener
    func refreshChannelList(onComplete : @escaping Constants.CompletionHandler){
        
        
        socket.on(CHANNEL_CREATED_EVENT) { (data, ack) in
            
            guard let channelName = data[0] as? String else{ return}
            guard let channelDesc = data[1] as? String else{ return}
            guard let channelId = data[2] as? String else{ return}
            
            let channel = Channel(forId: channelId, forName: channelName, forDesc: channelDesc)
            MessageService.instance.appendChannel(channel)
            onComplete(true)
            
        }
        
        
    }
    
    func stablishConnection(){
        
        socket.connect()
    }
    
    func closeConnection(){
        
        socket.disconnect()
    }
    
    
    
}
