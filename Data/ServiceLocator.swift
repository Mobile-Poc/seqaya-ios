//
//  ServiceLocator.swift
//  seqayaPoc
//
//  Created by Guest on 2018-04-05.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation
class ServiceLocator{
    
    static func  getGetPlacedOrderUseCase() -> (GetPlacedOrderUseCaseProtocol){
        return GetPlacedOrderUseCase()
    }
    
    static func  getOrderHistoryUseCase() -> (GetOrderHistoryUCProtocol){
        
        return GetOrderHistoryUseCase()
    }
    
    static func getOrderHistoryRepository()-> OrderHistoryRepositoryProtocol{
        return OrderHistoryRepository()
    }
}
