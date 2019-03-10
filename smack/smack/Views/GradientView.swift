//
//  GradientView.swift
//  smack
//
//  Created by Eduardo Perez on 3/9/19.
//  Copyright © 2019 Eduardo Perez. All rights reserved.
//

import UIKit


@IBDesignable //this annotation allows to see the changes in Interface Builder in real time
class GradientView: UIView {

    @IBInspectable  var topColor : UIColor = UIColor.blue { //the IBInspectable decorator allows to make a property of a visual component to be editable in the attribute inspector
        didSet{
            
            //property observer to check when the property value has changed
            self.needsUpdateConstraints() //needsUpdateConstraints : invalid the current value of the layout, and update the value of this view
        }
        
        
    }
    
    @IBInspectable  var bottomColor : UIColor = UIColor.green { //the IBInspectable decorator allows to make a property of a visual component to be editable in the attribute inspector
        didSet{
            //property observer to check when the property value has changed
            self.needsUpdateConstraints()
        }
        
        
    }
    
    //this method is invoked when there is a call to needsUpdateConstraints , it allows to say the view what is going to happen when the lauout is updated
    
    //when  the needsUpdateConstraints is  called , the layout of the view is updated , then the layoutSubviews is invoked
    //use the layoutSubviews to indicate the view what to do when the layout is updated
    override func layoutSubviews() {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
        
        
    }

    
    

}
