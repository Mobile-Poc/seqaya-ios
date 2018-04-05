//
//  GetPlacedOrderUseCase.swift
//  seqayaPoc
//
//  Created by Guest on 2018-04-04.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation
class GetPlacedOrderUseCase:GetPlacedOrderUseCaseProtocol{
    
    var orderSummaryRepo:OrderSummaryRepositoryProtocol?
    
    init(){
        
        //FIXME: Add to service
        orderSummaryRepo = OrderSummaryRepository()
    
    }
    
    func execute(finalPlacedOrder:@escaping (_ paymentRespone:OrderHistory)->()) {
        orderSummaryRepo?.getPlacedOrder(completion: {(placedOrder) in

            finalPlacedOrder(placedOrder)
        
        })
    }
    
    
    
}
