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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        closeButton.addTarget(self, action: #selector(LoginViewController.onPressedCloseButton), for: .touchUpInside)
        
        createAccountButton.addTarget(self, action: #selector(LoginViewController.onPressedCreateAccount), for: .touchUpInside)

        // Do any additional setup after loading the view.
    }
    
    
    @objc func onPressedCloseButton(){
        
        //dispose the current instance of this LoginViewController
        dismiss(animated: true, completion: nil)
        
    }
    
    @objc func onPressedCreateAccount(){
        
        performSegue(withIdentifier: Constants.TO_CREATE_ACCOUNT, sender: self)
    }
    

    

}
