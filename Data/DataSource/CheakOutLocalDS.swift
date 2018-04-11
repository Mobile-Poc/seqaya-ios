//
//  CheakOutLocalDS.swift
//  seqayaPoc
//
//  Created by Mariam Elsayed Ismail on 4/11/18.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation

struct CheakOutDS {
    
    func getOrders()->[OrderItem]{
        
        return OrderItemsSingelton.instance.orderItems
    }
}
