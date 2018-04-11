//
//  UpdateOrderUseCase.swift
//  seqayaPoc
//
//  Created by Mariam Elsayed Ismail on 4/5/18.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation






class UpdateOrderUseCase:UpdateOrdertUCPr {
    
    var worker : UpdateOrderReposatiry
    
    init() {
        let worker =  OrdersWorker() 
        self.worker = worker
    }
    
    func updateOrder(_ orders :[OrderItem]){
        
        worker.updateOrder(orders)
    }
    
}
