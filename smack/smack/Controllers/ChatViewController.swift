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
    
    override func viewDidAppear(_ animated: Bool) {
        debugPrint("ChatViewController viewDidAppear")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        debugPrint("ChatViewController viewDidLoad")
        //object?.addTarget(objectWhichHasMethod, action: #selector(classWhichHasMethod.yourMethod), for: someUIControlEvents)

        menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: UIControl.Event.touchUpInside)
    
        
        self.view.addGestureRecognizer(self.revealViewController()!.tapGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController()!.panGestureRecognizer())
        
        if AuthServices.instance.isLogged {
            AuthServices.instance.findUserByEmail { (isSucces) in
                
                //at this moment , since the channel viewcontroller is the only observer for this notification
                //and hasn't been loaded yet, the following post notificartion will have been lost , so
                //in order to render the user data properly we had to hooked up the viewdidAppear event in the channelviewController
                NotificationCenter.default.post(name: Constants.NOTIFICATION_CHANGED_DATA_USER, object: nil)
            }
            
        }
        
        MessageService.instance.findAllChannels { (isSucess) in
            debugPrint(MessageService.instance.channels)
        }
        
        // Do any additional setup after loading the view.
    }
    

}
