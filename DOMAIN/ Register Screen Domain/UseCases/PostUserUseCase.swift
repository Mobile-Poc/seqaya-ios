//
//  PostUserUseCase.swift
//  seqayaPoc
//
//  Created by NTG-Apple12 on 2018-04-04.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation

class PostUserUseCase:  PostUserUseCaseProtocol {
     
    let PostUserReposiroty: RegisterUserRepository = CreateUser()
    
    func PostUser(name: String , email:String, password:String ,phoneNumber: String, success: @escaping (Data) -> Void, failure: @escaping (String) -> Void) {
        
        PostUserReposiroty.PostUser(name: name , email:email, password:password , phoneNumber: phoneNumber, success: { (sucss) in
            success(sucss)
            print("second sucess")
            
        }) { (fail) in
            
            failure(fail)
            print("second fail")
        }
        
    }
    
    
    
}
