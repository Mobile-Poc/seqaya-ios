//
//  getHist.swift
//  seqayaPoc
//
//  Created by Guest on 2018-04-05.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation

class GetOrderHistoryUseCase: GetOrderHistoryUCProtocol {
   
    var orderHistoryRepo: OrderHistoryRepositoryProtocol?
    
    init(){
        
        //FIXME: Add to service
        orderHistoryRepo = ServiceLocator.getOrderHistoryRepository()
    }
    
    func execute(usermail: String, historyResult: @escaping ([OrderHistoryObj]) -> ()) {
        orderHistoryRepo?.getOrderHistory(usermail: usermail, completion:{ (historyRes) in
            historyResult(historyRes)
        }
        )
    }
    
}
