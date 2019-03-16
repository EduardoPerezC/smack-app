//
//  ChannelViewController.swift
//  smack
//
//  Created by Eduardo Perez on 3/9/19.
//  Copyright © 2019 Eduardo Perez. All rights reserved.
//

import UIKit

class ChannelViewController: UIViewController {

    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.addTarget(self, action: #selector(ChannelViewController.onPressedLoginButton), for: .touchUpInside)
        
        self.revealViewController()?.rearViewRevealWidth =  self.view.frame.width - 60
        // Do any additional setup after loading the view.
    }
    
    
    @objc func onPressedLoginButton(){
        
        
        performSegue(withIdentifier: Constants.TO_LOGIN, sender: self)
        
    }
    
    
    //this method will be invoked to return from CreateAccountControllers
    @IBAction func unwindToChannelView(segue : UIStoryboardSegue){
        
    
        
    }
    

    
}
