//
//  SavedLocationNetwork.swift
//  seqayaPoc
//
//  Created by admin101 on 3/27/18.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation
import Alamofire

class SavedLocationNetwork {
    
    let alamaofireClient = AlamaofireClient()
    
    func get(compilation: @escaping ([SavedLocation]) -> ()){
        let usermail = UserDefaults.standard.object(forKey: "email") as! String ?? ""
        
        alamaofireClient.requestGETURL(strURL: "\(SAVED_LOCATION)/\(usermail)", params: nil, success: { (data) in
            //print(data)
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode([SavedLocation].self, from: data!)
                
                compilation(result)
        
            }catch let error{
                print(error)
            }
        }) { (error) in
            
            print(error)
        }
        
    }
    
    
    func post(newlocation: SavedLocation , compilation: @escaping (Data) -> () , error: @escaping (String) -> ()) {
        let usermail = UserDefaults.standard.object(forKey: "email") as! String ?? ""
        let url = "http://mesawer.getsandbox.com/location"
        let params : Parameters = ["userId": usermail,"address":newlocation.address,"lat":newlocation.lat,"long":newlocation.long]

        alamaofireClient.requestPOSTURL(url: url, param: params, success: { (success) in
            compilation(success!)
        }) { (failure) in
            error(failure)
        }

    }
}
