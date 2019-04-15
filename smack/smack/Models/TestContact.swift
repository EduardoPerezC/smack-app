//
//  TestContact.swift
//  smack
//
//  Created by Eduardo Perez on 4/1/19.
//  Copyright © 2019 Eduardo Perez. All rights reserved.
//

import Foundation

class TestContact{
    
    private(set) var id : String
    private(set) var name : String
    
    public let company : String
    
    init(forId id : String, forName name : String){
        
        company = "this is the only company"
        self.id = id
        self.name = name
    }
    
    func getData(){
        
        //self.company = "sv"
        
    }
    
    

    
}
