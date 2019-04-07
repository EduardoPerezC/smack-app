//
//  Channel.swift
//  smack
//
//  Created by Eduardo Perez on 4/6/19.
//  Copyright © 2019 Eduardo Perez. All rights reserved.
//

import Foundation

struct Channel{
    
    public private(set) var id : String
    public private(set) var name : String
    public private(set) var description : String
    
    init(forId id : String,  forName name : String, forDesc description : String){
        
        self.id = id
        self.description = description
        self.name = name
    }
    
}
