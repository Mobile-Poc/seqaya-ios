//
//  OrderItemsSingelton.swift
//  seqayaPoc
//
//  Created by Guest on 2018-03-31.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation
class OrderItemsSingelton{
    
    private static var _instance = OrderItemsSingelton()
    private var _orderItems = [OrderItem]()
    private init(){}
    
    static var instance:OrderItemsSingelton{
        return _instance
    }
    
    var orderItems:[OrderItem]{
        return _orderItems
    }
    
    func updateItemQuant(_ quant:Int, indx: Int){
        self._orderItems[indx].quantity = quant
    }
    
    func appendNewItem(_ itemToAppend:OrderItem){
        self._orderItems.append(itemToAppend)
    }
    func updateOrderItems(_ orderItems:[OrderItem]){
        self._orderItems = orderItems
    }
}
