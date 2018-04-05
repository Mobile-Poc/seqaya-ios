//
//  SummaryNetwork.swift
//  seqayaPoc
//
//  Created by Guest on 2018-03-28.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation

class SummaryNetwork {
    
    let alamaofireClient = AlamaofireClient()
    
    func get(completion: @escaping ([OrderItem]) -> ()){
        
        alamaofireClient.requestGETURL(strURL: ORDER_URL, params: nil, success: { (data) in
            //print(data)
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode([OrderItem].self, from: data!)
                
                completion(result)
                
                
            }catch let error{
                print(error)
            }
        }) { (error) in
            
            print(error)
        }
        
    }
    
    func getFromOrderSingleton(completion:@escaping (_ orders:OrderHistory)->()){
        
        //FIX:-Must return a new object of type orderHistory
        
        completion(OrderHistory._orderHistory)
    }
    
}
