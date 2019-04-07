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
    @IBOutlet weak var loginImage: CircleImageView!
    @IBOutlet weak var tblvwChannels: UITableView! //delegating component
    private let CHANNEL_CELL_IDENTIFIER = "channelCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint("ChannelViewController viewDidLoad")
        loginButton.addTarget(self, action: #selector(ChannelViewController.onPressedLoginButton), for: .touchUpInside)
        
        self.revealViewController()?.rearViewRevealWidth =  self.view.frame.width - 60
        // Do any additional setup after loading the view.
        
        
        //here we add the listener for the NOTIFICATION_CHANGED_DATA_USER nofification
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelViewController.onUserDataChanged), name: Constants.NOTIFICATION_CHANGED_DATA_USER, object: nil)
        
        tblvwChannels.dataSource = self
        tblvwChannels.delegate = self
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        setUserInfo()
        
    }
    
    
    @objc func onUserDataChanged(){
        
        setUserInfo()
        
    }
    
    func setUserInfo(){
        
        if AuthServices.instance.isLogged {
            loginButton.setTitle(UserDataService.instance.name, for: .normal)
            loginImage.image = UIImage(named: UserDataService.instance.avatarName)
            loginImage.backgroundColor = UserDataService.instance.getSelectedAvatarColor(avatarColor: UserDataService.instance.avatarColor)
        }
        else{
            loginButton.setTitle("Login", for: .normal)
            loginImage.image = UIImage(named: "menuProfileIcon")
            loginImage.backgroundColor = UIColor.lightGray
        }
        
    }
    
    @objc func onPressedLoginButton(){
        
        if AuthServices.instance.isLogged {
            let profileVC = ProfileViewController() //creating an instance
            profileVC.modalPresentationStyle = .custom
            present(profileVC, animated: true, completion: nil)
            
        }else{
            performSegue(withIdentifier: Constants.TO_LOGIN, sender: self)
        }
        
    }
    
    
    //this method will be invoked to return from CreateAccountControllers
    @IBAction func unwindToChannelView(segue : UIStoryboardSegue){
        
    
        
    }
    

    
}


//this part represents the "delegate" role
//adding conforming UITableViewDataSource protocol with extension
extension ChannelViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return MessageService.instance.channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let channelCell =  tableView.dequeueReusableCell(withIdentifier: CHANNEL_CELL_IDENTIFIER) as? ChannelTableViewCell{
            channelCell.configure(channel: MessageService.instance.channels[indexPath.row])
            return channelCell
        }
        
        return ChannelTableViewCell()
    }
    
    
}
