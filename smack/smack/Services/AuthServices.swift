//
//  AuthServices.swift
//  smack
//
//  Created by Eduardo Perez on 3/14/19.
//  Copyright © 2019 Eduardo Perez. All rights reserved.
//

import Foundation

import Alamofire //import library to create web request

class AuthServices{
    
    public static let instance = AuthServices()
    
    private let userDefaults = UserDefaults.standard
    
    private init(){}
    
    var isLogged : Bool{
        get{
           return  userDefaults.bool(forKey: Constants.LOGGED_IN)
            
        }
        set{
            userDefaults.set(newValue, forKey: Constants.LOGGED_IN)
            
        }
    }
    
    var Tokken : String{
        get{
            return userDefaults.string(forKey: Constants.TOKEN)!
            
        }
        set{
            userDefaults.setValue(newValue, forKey: Constants.TOKEN)
        }
        
    }
    
    var userEmail : String{
        get{
            return userDefaults.string(forKey: Constants.USER_EMAIL)!
        }
        set{
            userDefaults.setValue(newValue, forKey: Constants.USER_EMAIL)
        }
        
    }
    
    func registerUser(forEmail email:String, forPassword password : String, onCompleted : @escaping Constants.CompletionHandler){
        
        let lowerUserEmail = email.lowercased()
        
        //declaring a HashMap<String,String>
        let header : [String:String] = [
            "Content-Type":"application/json; charset=utf-8"
        ]
        
        //declaring a HashMap<String,Object>
        let body:[String:Any]=[
            "email":lowerUserEmail,
            "password":password
        ]
        
        
        //async process
        Alamofire.request(Constants.REGISTER_SERVICE_URL, method: .post, parameters: body,
                          encoding: JSONEncoding.default, headers: header).responseString { (response) in
                            
                            if(response.error == nil){
                                onCompleted(true)
                            }
                            else{
                                onCompleted(false)
                            }
        }
        print("request process started")
        
        
        
    }
    
    
    
    
}
