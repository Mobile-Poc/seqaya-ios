//
//  OrderHistoryMainPresenter.swift
//  seqayaPoc
//
//  Created by Guest on 2018-04-05.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation
class OrderHistoryMainPresenter :OrderHistoryMainPresenterProtocol {
   
    var orderHistMainVC: OrderHistoryMainProtocol?
    
    var getOrderHistoryUC : GetOrderHistoryUCProtocol?
    
    required init(vc: OrderHistoryMainProtocol) {
        orderHistMainVC = vc
        getOrderHistoryUC = ServiceLocator.getOrderHistoryUseCase()
        
    }
    
    func getHistoryMain(user: String) {
    
        getOrderHistoryUC?.execute(usermail: user, historyResult: {
            (result) in
            
            self.orderHistMainVC?.showOrderHistoryMain(result)
            
        })
        
    }
  
}
