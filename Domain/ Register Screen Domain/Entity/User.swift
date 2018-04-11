//
//  User.swift
//  seqayaPoc
//
//  Created by NTG-Apple12 on 2018-04-04.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation

class User {
    
    let Name: String
    let Email: String
    let Password: String
    let Phone: String
    
    
    
    init(name: String , email: String , password: String , phone: String) {
        self.Name = name
        self.Email = email
        self.Password = password
        self.Phone = phone
    }
    
}
