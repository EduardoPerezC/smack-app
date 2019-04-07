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
    
    public private(set)  var channels : [Channel] = []
    
    private init(){}
    
    func findAllChannels(onComplete : @escaping Constants.CompletionHandler){
        
        Alamofire.request(Constants.FIND_ALL_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Constants.BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil{
                
                guard let data = response.data else {return}
                
                let jsonData = JSON(data)
                self.channels =  jsonData.arrayValue.map({ (jsonChannelItem) -> Channel in
                    return  Channel(forId: jsonChannelItem["_id"].stringValue,  forName: jsonChannelItem["name"].stringValue, forDesc: jsonChannelItem["description"].stringValue)
                })
                
                onComplete(true)
            }
            else{
                onComplete(false)
            }
        }
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
    
}
