//
//  Contact.swift
//  CoreDataCRUD
//
//  Created by Ary on 22/07/2020.
//  Copyright © 2020 Ary. All rights reserved.
//

import Foundation

class Contact
{
     var name:String!
     var phone:String!
    
    init(name:String, phone:String) {
        
        self.name = name
        self.phone = phone
    }
    
    init()
    {
        self.name  = ""
        self.phone = ""
    }
}
