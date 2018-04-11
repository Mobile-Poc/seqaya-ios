//
//  OrderWorker.swift
//  seqayaPoc
//
//  Created by Mariam Elsayed Ismail on 4/5/18.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation


class OrdersWorker : UpdateOrderReposatiry,FetchOrderReposatiry
{

    
    func fetchOrders(Handler: @escaping ([OrderItem]) -> Void){
        
         let orders = CheakOutDS().getOrders()
        Handler(orders)
        
    }

    
    
    func updateOrder(_ orders: [OrderItem]) {
        
        OrderItemsSingelton.instance.updateOrderItems(orders)
       
    }
    
}
