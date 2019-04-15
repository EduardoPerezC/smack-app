//
//  UserDataService.swift
//  smack
//
//  Created by Eduardo Perez on 3/16/19.
//  Copyright © 2019 Eduardo Perez. All rights reserved.
//

import Foundation

class UserDataService{
    
    public static let instance = UserDataService()
    
    private init(){}
    
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    func setUserData(forId id : String, forAvatarColor avatarColor : String, forAvatarName avatarName: String, forEmail email : String, forName name : String){
        self.id = id
        self.avatarColor = avatarColor
        self.avatarName = avatarName
        self.email = email
        self.name = name
        
    }
    
    func setAvatarName(forAvatarName avatarName: String){
        self.avatarName = avatarName
    }
    
    func getSelectedAvatarColor(avatarColor : String) -> UIColor{
        
        //sample avatarcolor value [0.5, 0.5, 0.5, 1]
        //before scanning  0.5,0.5,0.5,1
        
        let scanner = Scanner(string: avatarColor)
        let charsToBeSkipped = CharacterSet(charactersIn: "[], ")
        let charsUpTo = CharacterSet(charactersIn: ",")
        
        scanner.charactersToBeSkipped = charsToBeSkipped
        
        var r,g,b,a : NSString?
        
        //scan up to the comma, ignore the skipped character set
        scanner.scanUpToCharacters(from: charsUpTo, into: &r)
        
        //the scanner continues where it left off
        scanner.scanUpToCharacters(from: charsUpTo, into: &g)
        scanner.scanUpToCharacters(from: charsUpTo, into: &b)
        scanner.scanUpToCharacters(from: charsUpTo, into: &a)
        
        
        let defaultColor = UIColor.lightGray
        
        guard let rUnwrapped = r else { return defaultColor}
        guard let gUnwrapped = g else { return defaultColor}
        guard let bUnwrapped = b else { return defaultColor}
        guard let aUnwrapped = a else { return defaultColor}
        
        
        let fRed =  CGFloat(rUnwrapped.doubleValue)
        let fGreen =  CGFloat(gUnwrapped.doubleValue)
        let fBlue =  CGFloat(bUnwrapped.doubleValue)
        let fAlpha =  CGFloat(aUnwrapped.doubleValue)
        
        return UIColor(red: fRed, green: fGreen, blue: fBlue, alpha: fAlpha)
        
        
    }
    
    func logoutUser(){
        
        self.id = ""
        self.avatarName = ""
        self.avatarColor = ""
        self.email = ""
        self.name = ""
        AuthServices.instance.isLogged = false
        AuthServices.instance.Tokken = ""
        AuthServices.instance.userEmail = ""
        MessageService.instance.clearChannels()
        MessageService.instance.selectedChannel = nil
        
    }


}
