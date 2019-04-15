//
//  MessageService.swift
//  smack
//
//  Created by Eduardo Perez on 4/6/19.
//  Copyright © 2019 Eduardo Perez. All rights reserved.
//

import Foundation
import Alamofire //import library to create web request
import SwiftyJSON

class MessageService{
    
    public static let instance = MessageService()
    
    public private(set) var channels : [Channel] = []
    public private(set) var messages : [Message] = []
    
    public var selectedChannel : Channel? {
        didSet{
            NotificationCenter.default.post(name: Constants.NOTIFICATION_SELECTED_CHANNEL, object: nil)
            
        }
    }
    
    private init(){}
    
    func findAllChannels(onComplete : @escaping Constants.CompletionHandler){
        
        Alamofire.request(Constants.FIND_ALL_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Constants.BEARER_HEADER).responseJSON { (response) in
            
            
            debugPrint("clousure code after calling function returns")
            if response.result.error == nil{
                
                guard let data = response.data else {return}
                
                let jsonData = JSON(data)
                self.channels =  jsonData.arrayValue.map({ (jsonChannelItem) -> Channel in
                    return  Channel(forId: jsonChannelItem["_id"].stringValue,  forName: jsonChannelItem["name"].stringValue, forDesc: jsonChannelItem["description"].stringValue)
                })
                
                //set the first channel as a the selected default
                if self.channels.count > 0 {
                    self.selectedChannel = self.channels[0]
                }
                
                NotificationCenter.default.post(name: Constants.NOTIFICATION_CHANNELS_LOADED, object: nil)
                onComplete(true)
            }
            else{
                onComplete(false)
            }
        }
    }
    
    func appendChannel(_ channel : Channel){
        self.channels.append(channel)
        
    }
    
    func appendMessage(newMessage : Message){
        self.messages.append(newMessage)
        
    }
    
    func clearChannels(){
        
        self.channels.removeAll()
    }
    
    func addChannel(forName name : String, forDesc description : String, onComplete : @escaping Constants.CompletionHandler){
        
        let parameters = [
            "name": name,
            "description": description
        ]
        
        Alamofire.request(Constants.ADD_CHANNEL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: Constants.BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil{
                onComplete(true)
            }
            else{
                onComplete(false)
            }
        
        }
        
        
    }
    
    func findAllMessagesByChannel(forChannelId channelId : String, callback onCompleted: @escaping Constants.CompletionHandler ){
        
        guard let selectedChannelValue = self.selectedChannel else { return }
        
        let requestURL = "\(Constants.FIND_MSG_BY_CHANNEL)\(selectedChannelValue.id)"
        
        Alamofire.request(requestURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Constants.BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                
                guard let responseData = response.data else { return }
                
                let aJsonItems = JSON(responseData).arrayValue
                
                self.messages = aJsonItems.map({ (jsonItem) -> Message in
                    
                    return Message(forId: jsonItem["_id"].stringValue, messageBody: jsonItem["messageBody"].stringValue, userId: jsonItem["userId"].stringValue, channelId: jsonItem["channelId"].stringValue, userName: jsonItem["userName"].stringValue, userAvatar: jsonItem["userAvatar"].stringValue, userAvatarColor: jsonItem["userAvatarColor"].stringValue, timeStamp: jsonItem["timeStamp"].stringValue)
                })
                
                debugPrint(self.messages)
                debugPrint("findAllMessagesByChannel executed successfully")
                onCompleted(true)
            }
            else{
                onCompleted(false)
                debugPrint(response.result.error as Any)
            }
            
        }
    }
    
}
