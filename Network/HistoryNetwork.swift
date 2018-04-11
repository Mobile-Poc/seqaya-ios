//
//  HistoryNetwork.swift
//  seqayaPoc
//
//  Created by Guest on 2018-03-28.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation

class HistoryNetwork {
    
    let alamaofireClient = AlamaofireClient()
    
    func get(id:String ,completion: @escaping ([OrderHistoryObj]?) -> ()){
        ///\(id)
        
        let usermail = UserDefaults.standard.object(forKey: "email") as! String ?? ""
        alamaofireClient.requestGETURL(strURL: ORDER_URL + "/" + usermail, params: nil, success: { (data) in
            //print(data)
            do {
                let decoder = JSONDecoder()
                
                let result = try decoder.decode([OrderHistoryObj].self , from: data!)
                
                if result.count>0{
                    completion(result)
                }
                else{
                     completion(nil)
                }
                
                
            }catch let error{
                print(error)
            }
        }) { (error) in
            
            print(error)
        }
        
    }
    
}
