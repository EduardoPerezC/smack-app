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
