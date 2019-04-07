//
//  CreateAccountViewController.swift
//  smack
//
//  Created by Eduardo Perez on 3/9/19.
//  Copyright © 2019 Eduardo Perez. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var userEmailtxt: UITextField!
    @IBOutlet weak var pwdTxt: UITextField!
    @IBOutlet weak var profileDefaultImg: UIImageView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    //default profile properties
    var avatarName = "profileDefault"
    
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    
    var bgColor : UIColor? //keep track of the color generated
    
    func setUpView(){
        
        spinner.isHidden = true
        userNameTxt.attributedPlaceholder =  NSAttributedString(string: userNameTxt.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.3266413212, green: 0.4215201139, blue: 0.7752227187, alpha: 1)])
        
        userEmailtxt.attributedPlaceholder =  NSAttributedString(string: userEmailtxt.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.3266413212, green: 0.4215201139, blue: 0.7752227187, alpha: 1)])
        
        pwdTxt.attributedPlaceholder =  NSAttributedString(string: pwdTxt.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.3266413212, green: 0.4215201139, blue: 0.7752227187, alpha: 1)])
        
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setUpView()
        print("on viewDidLoad")
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        print("on viewDidAppear")
        
        if UserDataService.instance.avatarName != "" {
            print("image selected\(UserDataService.instance.avatarName)")
            avatarName = UserDataService.instance.avatarName
            profileDefaultImg.image = UIImage(named: avatarName)
            
            if avatarName.contains("light") && bgColor == nil{
                profileDefaultImg.backgroundColor = UIColor.lightGray
            }
           
        }
        
    }
    
    
    
    @IBAction func onGenerateBgrdColor(_ sender: Any) {
        
        //this method will generate a random background color
        let red =  CGFloat(arc4random_uniform(255)) / 255
        let green =  CGFloat(arc4random_uniform(255)) / 255
        let blue =  CGFloat(arc4random_uniform(255)) / 255
        
        self.bgColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
        
        //adding animation, fade-out animation by default
        UIView.animate(withDuration: 0.2) {
            self.profileDefaultImg.backgroundColor = self.bgColor
        }
        self.avatarColor = "[\(red),\(green), \(blue),1]"  //interpolation
        
        
    }
    
    @IBAction func onPressedCreateAvatarBtn(_ sender: Any) {
        
        self.performSegue(withIdentifier: Constants.TO_AVATARPICKUP, sender: nil)
    }
    
    func isValidEmail(email:String)->Bool{
        
      return  email.contains("@")
        
    }
    
    @IBAction func onCreateAccountBtn(_ sender: Any) {
        
        //guard statement to perform early exit of the function
        guard let userEmail = userEmailtxt.text, userEmail != "", isValidEmail(email: userEmail) else {
            print("invalid email")
            return
        }
        
        guard let pwd = pwdTxt.text, pwd != "" else {
            return
        }
        
        guard let name = userNameTxt.text, name != "" else {
            return
        }
        
        
        //starting the activity indicator when the registry  process begins
        spinner.isHidden = false
        spinner.startAnimating()
        //we pass the clousure as a trailing clousure
        AuthServices.instance.registerUser(forEmail: userEmail, forPassword: pwd) { (success) in
            
            AuthServices.instance.loginUser(forEmail: userEmail, forPassword: pwd, onCompleted: { (success) in
                if success{
                    print("successfully logged in")
                    
                    AuthServices.instance.createUser(forAvatarColor: self.avatarColor, forAvatarName: self.avatarName, forEmail: userEmail, forName: name, onCompleted: { (success) in
                        
                        if success {
                            print("successfully created user")
                            
                            self.spinner.stopAnimating()
                            self.spinner.isHidden = false
                            NotificationCenter.default.post(name: Constants.NOTIFICATION_CHANGED_DATA_USER, object: nil)
                            //the performSegue is also used to call unwind methods
                            self.performSegue(withIdentifier: Constants.TO_CHANNEL, sender: nil)
                        }
                    })
                    
                }
            })
            
            if success {
                print("sucessfully registered")
            }
            
            
        }
        print("return from AuthServices.instance.registerUser call")
        
        
    }
    
    
    
    @IBAction func onPressedCloseButton(_ sender: Any) {
        
        //the performSegue is also used to call unwind methods
        performSegue(withIdentifier: Constants.TO_CHANNEL, sender: self)
        
    }
    
    @IBAction func unwindToCreateAccount(segue : UIStoryboardSegue){
        
        
    }

}
