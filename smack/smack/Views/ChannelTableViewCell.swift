//
//  ChannelTableViewCell.swift
//  smack
//
//  Created by Eduardo Perez on 4/6/19.
//  Copyright © 2019 Eduardo Perez. All rights reserved.
//

import UIKit

class ChannelTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblChannelName: UILabel!
    
    func configure(channel : Channel){
        lblChannelName.text = channel.name
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            self.backgroundColor = UIColor(white: 1, alpha: 0.2)
        }
        else{
            self.backgroundColor = UIColor.clear
        }
        
        // Configure the view for the selected state
    }

}
