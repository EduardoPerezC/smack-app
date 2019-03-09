//
//  ChatViewController.swift
//  smack
//
//  Created by Eduardo Perez on 3/9/19.
//  Copyright © 2019 Eduardo Perez. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    
    @IBOutlet weak var menuButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //object?.addTarget(objectWhichHasMethod, action: #selector(classWhichHasMethod.yourMethod), for: someUIControlEvents)

        menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: UIControl.Event.touchUpInside)
    
        
        self.view.addGestureRecognizer(self.revealViewController()!.tapGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController()!.panGestureRecognizer())
        
        // Do any additional setup after loading the view.
    }
    

}
