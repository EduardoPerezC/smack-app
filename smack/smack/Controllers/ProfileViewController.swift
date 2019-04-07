//
//  ProfileViewController.swift
//  smack
//
//  Created by Eduardo Perez on 4/2/19.
//  Copyright © 2019 Eduardo Perez. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserEmail: UILabel!
    @IBOutlet weak var imgUserAvatar: UIImageView!
    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var bgView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnLogout.addTarget(self, action: #selector(ProfileViewController.onPressLogOutBtn), for: .touchUpInside)
        
        closeBtn.addTarget(self, action: #selector(ProfileViewController.onClose), for: .touchUpInside)
        
        setUpView()
        // Do any additional setup after loading the view.
    }
    
    func setUpView(){
        
        lblUserName.text = UserDataService.instance.name
        lblUserEmail.text = UserDataService.instance.email
        imgUserAvatar.image = UIImage(named: UserDataService.instance.avatarName)
        imgUserAvatar.backgroundColor = UserDataService.instance.getSelectedAvatarColor(avatarColor: UserDataService.instance.avatarColor)
        
        
    }
    
    @objc func onPressLogOutBtn(){
        
        UserDataService.instance.logoutUser()
        NotificationCenter.default.post(name: Constants.NOTIFICATION_CHANGED_DATA_USER, object: nil)
        dismiss(animated: true, completion: nil)
        
    }
    
    @objc func onClose(){
        
        dismiss(animated: true, completion: nil)
        
    }


   

}
