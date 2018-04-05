//
//  OrderHistoryRepository.swift
//  seqayaPoc
//
//  Created by Guest on 2018-04-05.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation
class OrderHistoryRepository :OrderHistoryRepositoryProtocol {
    
    
    func getOrderHistory(usermail:String , completion:@escaping ([OrderHistoryObj])->()){
        
        HistoryNetwork().get(id: usermail, completion: {(result)
            in
            if result != nil {
               completion(result!)
                
            }
        })
    }
    
   
}
