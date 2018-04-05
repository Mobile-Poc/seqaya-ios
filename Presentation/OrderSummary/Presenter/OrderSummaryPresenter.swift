//
//  OrderSummaryPresenter.swift
//  seqayaPoc
//
//  Created by Guest on 2018-04-04.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation
class OrderSummaryPresenter: OrderSummaryPresenterProtocol {
    var orderSummaryVC: OrderSummaryViewProtocol?
    var getplacedOrderUC:GetPlacedOrderUseCaseProtocol?
    required init(view: OrderSummaryViewProtocol) {
        
        orderSummaryVC = view
        getplacedOrderUC = ServiceLocator.getGetPlacedOrderUseCase()
    }
    
    func getPlacedOrder() {
        
       self.getplacedOrderUC?.execute(finalPlacedOrder: {
        (placedOrder) in            
            self.orderSummaryVC!.showOrderSummary(order:placedOrder)
       })
    }
    
    
}
