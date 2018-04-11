//
//  CreateUser.swift
//  seqayaPoc
//
//  Created by NTG-Apple12 on 2018-04-04.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation

class CreateUser: RegisterUserRepository {
    
    let alamoClient =  AlamaofireClient()
    
    func PostUser(name: String , email:String, password:String ,phoneNumber: String, success: @escaping (Data) -> Void, failure: @escaping (String) -> Void) {
        
        let targetUrl = "http://seqaya.getsandbox.com/user"
        let Parameter = ["name": name , "email": email, "phone": phoneNumber , "password": password]
        
        alamoClient.requestPOSTURL(url: targetUrl, param: Parameter, success: { (suss) in
            success(suss!)
            print("reg done")
            
        }) { (err) in
            
            failure(err)
            print("reg fali")
        }
        
    }
    
    //
    
    //
    
    //
    
    
}
