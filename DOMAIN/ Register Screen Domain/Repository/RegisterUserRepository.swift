//
//  RegisterUserRepository.swift
//  seqayaPoc
//
//  Created by NTG-Apple12 on 2018-04-04.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation

protocol RegisterUserRepository {
    
    func PostUser(name: String , email:String, password:String ,phoneNumber: String , success: @escaping (Data) -> Void, failure: @escaping (String) -> Void)
    //
    
    //  func  database
    
    //  func inventory
    
}
