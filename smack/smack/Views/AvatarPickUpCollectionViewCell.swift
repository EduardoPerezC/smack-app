//
//  AvatarPickUpCollectionViewCell.swift
//  smack
//
//  Created by Eduardo Perez on 3/18/19.
//  Copyright © 2019 Eduardo Perez. All rights reserved.
//

import UIKit

enum AvatarType{
    case dark
    case light
}

class AvatarPickUpCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak private var avatarImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    private func setUpView(){
        avatarImg.layer.backgroundColor = UIColor.gray.cgColor
        avatarImg.layer.cornerRadius = 10
        avatarImg.clipsToBounds = true
    }
    
    func configure(forIndexImage indexImage : Int, forType avatarType : AvatarType){
        
        if avatarType == AvatarType.dark {
            avatarImg.image = UIImage(named: "dark\(indexImage)")
            avatarImg.layer.backgroundColor = UIColor.lightGray.cgColor
        }
        else{
            avatarImg.image = UIImage(named: "light\(indexImage)")
            avatarImg.layer.backgroundColor = UIColor.darkGray.cgColor
        }
        
        
    }
    
    func setImage(forImage imageName : String){
        avatarImg.image = UIImage(named: imageName)
        
    }
    
    
}
