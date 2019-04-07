//
//  ProfileImageView.swift
//  smack
//
//  Created by Eduardo Perez on 3/26/19.
//  Copyright © 2019 Eduardo Perez. All rights reserved.
//

import UIKit

@IBDesignable
class CicleImageView: UIImageView {

    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    override func prepareForInterfaceBuilder() {
        setUpView()
    }
    
    func setUpView(){
        self.layer.cornerRadius = 3.0
        self.clipsToBounds = true
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
