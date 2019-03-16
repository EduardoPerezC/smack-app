//
//  CreateAccountViewController.swift
//  smack
//
//  Created by Eduardo Perez on 3/9/19.
//  Copyright © 2019 Eduardo Perez. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func onPressedCloseButton(_ sender: Any) {
        
        var firstChannel = AudioChannel()
        firstChannel.currentLevel = 6
        print(AudioChannel.maxInputLevelForAllChannels)
        
        var secondChannel = AudioChannel()
        secondChannel.currentLevel = 8
        print(AudioChannel.maxInputLevelForAllChannels)
        
        //the performSegue is also used to call unwind methods
        performSegue(withIdentifier: Constants.TO_CHANNEL, sender: self)
        
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
