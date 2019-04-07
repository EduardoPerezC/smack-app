//
//  RoundedButton.swift
//  smack
//
//  Created by Eduardo Perez on 3/16/19.
//  Copyright © 2019 Eduardo Perez. All rights reserved.
//

import UIKit


@IBDesignable
class RoundedButton: UIButton {

    //this method is used to set the default configuration of this control at runtime
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    //called when the control is created in Interface Builder
    
    override func prepareForInterfaceBuilder() {
        setUpView()
    }
    
    
    @IBInspectable var cornerRadius : CGFloat = 20.0{
        didSet{
            self.layer.cornerRadius = self.cornerRadius
            
        }
        
    }
    
    func setUpView(){
        self.layer.cornerRadius = self.cornerRadius
        //self.layer.cornerRadius
    }
    

}
