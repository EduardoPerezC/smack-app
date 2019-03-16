//
//  Constants.swift
//  smack
//
//  Created by Eduardo Perez on 3/9/19.
//  Copyright © 2019 Eduardo Perez. All rights reserved.
//

import Foundation

//segues

class Constants{
    
   private init(){}
    
    private static let BASE_URL = "https://app-jepc-smack-api.herokuapp.com/v1/"
    static let REGISTER_SERVICE_URL = "\(Constants.BASE_URL)account/register"  //using string interpolation to join strings
    
    typealias CompletionHandler = (_ isSuccess : Bool)->()
    
    static let TO_LOGIN = "fromChatToLogin"
    static let TO_CREATE_ACCOUNT = "fromLoginToCreateAccount"
    static let TO_CHANNEL = "unwindReturnToChannelVC"
    
    //User default constant (these adjustments will be restored everytime the app launches
    static let LOGGED_IN = "isLogged"
    static let TOKEN = "token"
    static let USER_EMAIL = "userEmail"
    
}



