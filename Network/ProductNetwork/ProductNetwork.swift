//
//  ProductNetwork.swift
//  seqayaPoc
//
//  Created by Ahmed Fadl on 3/27/18.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation

class ProductNetwork {
    
    let alamaofireClient = AlamaofireClient()
    
    func get(compilation: @escaping ([CartItem]) -> ()){
        
        alamaofireClient.requestGETURL(strURL: PRODUCT_URL, params: nil, success: { (data) in
            //print(data)
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode([CartItem].self, from: data!)
                
                    compilation(result)
                
                
            }catch let error{
                  print(error)
            }
        }) { (error) in
            
            print(error)
        }
        
    }
    
}
