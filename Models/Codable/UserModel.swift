//
//  UserModel.swift
//  seqayaPoc
//
//  Created by admin101 on 3/28/18.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation

struct UserModel : Codable {
//    var email : String
//    var id : String
//    var name : String
//    var password : String
//    var phoneNumber : String
//
//    init(mail: String, id : String , name : String , password: String , phonenumber: String) {
//        self.email = mail
//        self.id = id
//        self.name = name
//        self.password = password
//        self.phoneNumber = phonenumber
//    }
    
    var email : String
    //var id : String
    var name : String
    var password : String
    var phoneNumber : String
    var shoppingCart: Items?
    
    //id : String ,
    init(mail: String,  name : String , password: String , phonenumber: String) {
        self.email = mail
        // self.id = id
        self.name = name
        self.password = password
        self.phoneNumber = phonenumber
        self.shoppingCart = nil
    }
}
