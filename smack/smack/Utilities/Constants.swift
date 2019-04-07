//
//  Constants.swift
//  smack
//
//  Created by Eduardo Perez on 3/9/19.
//  Copyright © 2019 Eduardo Perez. All rights reserved.
//

import Foundation
import UIKit

//segues

class Constants{
    
   private init(){}
    
    private static let BASE_URL = "https://app-jepc-smack-api.herokuapp.com/v1/"
    static let REGISTER_SERVICE_URL = "\(Constants.BASE_URL)account/register"  //using string interpolation to join strings
    static let LOGIN_USER_URL = "\(Constants.BASE_URL)account/login"
    static let ADD_USER = "\(Constants.BASE_URL)user/add"
    static let FIND_USER_BY_EMAIL = "\(Constants.BASE_URL)/user/byEmail/"
    static let FIND_ALL_CHANNELS = "\(Constants.BASE_URL)channel"
    static let ADD_CHANNEL = "\(Constants.BASE_URL)channel/add"
    
    typealias CompletionHandler = (_ isSuccess : Bool)->()
    
    
    //segues identifier names
    static let TO_LOGIN = "fromChatToLogin"
    static let TO_CREATE_ACCOUNT = "fromLoginToCreateAccount"
    static let TO_CHANNEL = "unwindReturnToChannelVC"
    static let TO_AVATARPICKUP = "toAvatarPickUp"
    static let BACK_TO_CREATE_ACCOUNT = "backToCreateAccountVC"
    
    //Notification constants
    
    //creating the name of the notification
    static let NOTIFICATION_CHANGED_DATA_USER = Notification.Name("ChangeDataUserNotification")
    
    //User default constant (these adjustments will be restored everytime the app launches
    static let LOGGED_IN = "isLogged"
    static let TOKEN = "token"
    static let USER_EMAIL = "userEmail"
    
    //Header Request
    
    //declaring a HashMap<String,String>
    static let REQUEST_HEADER : [String:String] = [
        "Content-Type":"application/json; charset=utf-8",
    ]
    
    static let BEARER_HEADER : [String : String] = [
        "Content-Type":"application/json; charset=utf-8",
        "Authorization": "Bearer \(AuthServices.instance.Tokken)"
    ]
    
    
}



