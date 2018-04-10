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
    
    let  alamaofireClient = AlamaofireClient()
    
    func get(userEmail:String , compilation: @escaping ([SavedLocation]) -> ()){
        let usermail = UserDefaults.standard.object(forKey: "email") as! String ?? ""
        
        alamaofireClient.requestGETURL(strURL: "\(SAVED_LOCATION)/\(userEmail)", params: nil, success: { (data) in
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode([SavedLocation].self, from: data!)
                print("SavedLocationNetwork")
                compilation(result)
        
            }catch let error{
                print(error)
            }
        }) { (error) in
            
            print(error)
        }
        
    }
    
    
    func post(newlocation: SavedLocation , compilation: @escaping (String) -> ()) {
        let usermail = UserDefaults.standard.object(forKey: "email") as! String ?? ""
        let url = "http://mesawer.getsandbox.com/location"
        let params : Parameters = ["userId": usermail,"address":newlocation.address,"lat":newlocation.lat,"long":newlocation.long]

        alamaofireClient.requestPOSTURL(url: url, param: params, success: { (success) in
            
            if let result = success
            {
                compilation("Location Saved")

            }
        }) { (failure) in
            compilation("Location Not Saved")

        }

    }
}
