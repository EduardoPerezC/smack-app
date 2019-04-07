//
//  AvatarPickUpViewController.swift
//  smack
//
//  Created by Eduardo Perez on 3/16/19.
//  Copyright © 2019 Eduardo Perez. All rights reserved.
//

import UIKit

class AvatarPickUpViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private let AVATAR_CELL_IDENTIFIER = "avatarPickUpCell"
    
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var avatarTypeSegmentCtrl: UISegmentedControl!
    
    @IBOutlet weak var avatarCollectionView: UICollectionView!
    
    private var selectedAvatarType : AvatarType = AvatarType.dark
    
    
    @IBAction func onAvatarTypeValueChanged(_ sender: Any) {
        
        if avatarTypeSegmentCtrl.selectedSegmentIndex == 0 {
            selectedAvatarType = .dark
        }
        else{
            selectedAvatarType = .light
        }
        
        //reload the collection  view/table
        avatarCollectionView.reloadData()
    
    }
    
    //method to provide addtional initialization on views that were loaded from a NIB or storyboard
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn.addTarget(self, action: #selector(AvatarPickUpViewController.onPressedBackButton), for: .touchUpInside)
        avatarCollectionView.dataSource = self
        avatarCollectionView.delegate  = self
        // Do any additional setup after loading the view.
    }
    
    //by setting the count , the view will automatically create the cells for the section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 28
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        print("\(#function) --- section = \(indexPath.section), row = \(indexPath.row)")
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AVATAR_CELL_IDENTIFIER, for: indexPath) as? AvatarPickUpCollectionViewCell {
            cell.configure(forIndexImage: indexPath.row, forType: self.selectedAvatarType)
            return cell
        }
        
        return AvatarPickUpCollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       let selectedImageName = selectedAvatarType == .dark ?  "dark\(indexPath.row)" : "light\(indexPath.row)"
       UserDataService.instance.setAvatarName(forAvatarName: selectedImageName)
       dismiss(animated: true, completion: nil)
        
    }
    
    @objc func onPressedBackButton(){
        
       dismiss(animated: true, completion: nil)
    }

    

}
