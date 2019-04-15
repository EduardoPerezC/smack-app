//
//  LoginViewController.swift
//  smack
//
//  Created by Eduardo Perez on 3/9/19.
//  Copyright © 2019 Eduardo Perez. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var btnLogin: RoundedButton!
    
    @IBOutlet weak var txtUserEmail: UITextField!
    @IBOutlet weak var txtPwd: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.isHidden = true
        
        closeButton.addTarget(self, action: #selector(LoginViewController.onPressedCloseButton), for: .touchUpInside)
        
        createAccountButton.addTarget(self, action: #selector(LoginViewController.onPressedCreateAccount), for: .touchUpInside)
        
        btnLogin.addTarget(self, action: #selector(LoginViewController.onPressedBtnLogin), for: .touchUpInside)

        // Do any additional setup after loading the view.
    }
    
    
    @objc func onPressedCloseButton(){
        
        //dispose the current instance of this LoginViewController
        dismiss(animated: true, completion: nil)
        
    }
    
    @objc func onPressedCreateAccount(){
        
        performSegue(withIdentifier: Constants.TO_CREATE_ACCOUNT, sender: self)
    }
    
    @objc func onPressedBtnLogin(){
        
        guard let userEmail = txtUserEmail.text, userEmail != "" else {return }
        
        guard let userPwd = txtPwd.text, userPwd != "" else {return }
        
        spinner.isHidden = false
        spinner.startAnimating()
        AuthServices.instance.loginUser(forEmail: userEmail, forPassword: userPwd) { (isSuccess) in
            
            //inside trailing clousure
            if isSuccess {
                AuthServices.instance.findUserByEmail(onCompleted: { (isSuccess) in
                  
                    if isSuccess {
                        self.spinner.stopAnimating()
                        self.spinner.isHidden = true
                        NotificationCenter.default.post(name: Constants.NOTIFICATION_CHANGED_DATA_USER, object: nil)
                        
                        debugPrint("before calling findAllChannels")
                        MessageService.instance.findAllChannels(onComplete: { (isSucess) in
                           
                        })
                        debugPrint("rest of the lines after findAllChannels returns")
                        
                        self.dismiss(animated: true, completion: nil)
                        
                    }
                    
                })
                
            }
            
            
        }
        
        
        
    }
    

    

}
