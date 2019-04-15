//
//  AddChannelViewController.swift
//  smack
//
//  Created by Eduardo Perez on 4/7/19.
//  Copyright © 2019 Eduardo Perez. All rights reserved.
//

import UIKit

class AddChannelViewController: UIViewController {

    
    @IBOutlet weak var txtChannelName: UITextField!
    @IBOutlet weak var txtChannelDesc: UITextField!
    @IBOutlet weak var btnCreateChannel: RoundedButton!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnClose.addTarget(self, action: #selector(AddChannelViewController.onClose), for: .touchUpInside)
        
        btnCreateChannel.addTarget(self, action: #selector(AddChannelViewController.onCreateChannel), for: .touchUpInside)
        
        spinner.isHidden=true
       
    }

    
    @objc func onClose(){
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @objc func onCreateChannel(){
        
        guard let channelName = txtChannelName.text, channelName != "" else {return }
        
        guard let channelDesc = txtChannelDesc.text, channelDesc != "" else {return }
        
        spinner.isHidden = false
        spinner.startAnimating()
        SocketService.instance.addChannel(forName: channelName, forDesc: channelDesc) { (isSuccess) in
            
            if isSuccess{
                self.spinner.stopAnimating()
                self.spinner.isHidden = true
                
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
