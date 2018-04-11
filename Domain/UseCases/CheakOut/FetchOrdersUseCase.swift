//
//  FetchOrdersUseCase.swift
//  seqayaPoc
//
//  Created by Mariam Elsayed Ismail on 4/10/18.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation


class FetchOrdersUseCase: FetchOrdersUcPr {
    
   weak var presenter: ShowOrderPresentationLogic?
    var worker : FetchOrderReposatiry
    
    init(presenter:ShowOrderPresentationLogic) {
        let worker =  OrdersWorker()
        self.worker = worker
        self.presenter = presenter
    }
    
    func fetchOrders() {
        
      
        
        // MARK: - Fetch order
        
        func getOrder()
        {
            
               worker.fetchOrders { orders -> Void in
                
                self.presenter?.presentOrder(response: orders)
            }
            
        }
        getOrder()
    }
    
    
}
