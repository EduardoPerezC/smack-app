//
//  AuthServices.swift
//  smack
//
//  Created by Eduardo Perez on 3/14/19.
//  Copyright © 2019 Eduardo Perez. All rights reserved.
//

import Foundation

import Alamofire //import library to create web request
import SwiftyJSON

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
        
        //declaring a HashMap<String,Object>
        let body:[String:Any]=[
            "email":lowerUserEmail,
            "password":password
        ]
        
        //async process
        Alamofire.request(Constants.REGISTER_SERVICE_URL, method: .post, parameters: body,
                          encoding: JSONEncoding.default, headers: Constants.REQUEST_HEADER).responseString { (response) in
                            
                            print("callback execution")
                            if(response.error == nil){
                                onCompleted(true)
                            }
                            else{
                                onCompleted(false)
                            }
        }
        print("request process started")
        
    }
    
    func loginUser(forEmail email:String, forPassword password : String, onCompleted : @escaping Constants.CompletionHandler){
        
        let lowerUserEmail = email.lowercased()
        
        //declaring a HashMap<String,Object>
        let body:[String:Any]=[
            "email":lowerUserEmail,
            "password":password
        ]
        
        //async process
        Alamofire.request(Constants.LOGIN_USER_URL, method: .post, parameters: body,
                          encoding: JSONEncoding.default, headers: Constants.REQUEST_HEADER).responseJSON { (response) in
                            
                            if response.result.error == nil{
                                
                                //early exit
                                guard let responseData = response.data else{ return }
                                
                                let json = JSON(responseData)
                                debugPrint(json)
                                self.userEmail = json["user"].stringValue
                                self.Tokken = json["token"].stringValue
                                self.isLogged = true
                                
                                onCompleted(true)
                                
                            }
                            else{
                                onCompleted(false)
                                
                            }
                            
        }
    }
    
    func setUserInfo(data : Data){
        
        let json = JSON(data)
        let id = json["_id"].stringValue
        let avatarColor = json["avatarColor"].stringValue
        let avatarName = json["avatarName"].stringValue
        let email = json["email"].stringValue
        let name = json["name"].stringValue
        
        debugPrint(name)
        debugPrint(avatarName)
        UserDataService.instance.setUserData(forId: id, forAvatarColor: avatarColor, forAvatarName: avatarName, forEmail: email, forName: name)
        
    }
    
    func createUser(forAvatarColor avatarColor : String, forAvatarName avatarName: String, forEmail email : String, forName name : String,
                    onCompleted : @escaping Constants.CompletionHandler)
    {
        let lowerUserEmail = email.lowercased()
        
        let body: [String:Any] = [
            "name": name,
            "avatarName": avatarName,
            "avatarColor": avatarColor,
            "email":lowerUserEmail
        ]
        
       Alamofire.request(Constants.ADD_USER, method: .post, parameters: body,
                         encoding: JSONEncoding.default, headers: Constants.BEARER_HEADER).responseJSON { (response) in
                            
                            if response.result.error == nil{
                                guard let data = response.data else { return }
                                
                                self.setUserInfo(data: data)
                                
                                onCompleted(true)
                            }
                            else{
                                onCompleted(false)
                            }
           }
    
    }
    
    func findUserByEmail(onCompleted : @escaping Constants.CompletionHandler){
        
        let requestURL = "\(Constants.FIND_USER_BY_EMAIL)\(AuthServices.instance.userEmail)" //string interpolation
        debugPrint(AuthServices.instance.userEmail)
        debugPrint(requestURL)
        
        Alamofire.request(requestURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Constants.BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil{
                
                guard let data = response.data else { return }
                
                self.setUserInfo(data: data)
                
                onCompleted(true)
                
            }
            else{
                onCompleted(false)
                
            }
        }
    }
    
        
    
    
}
