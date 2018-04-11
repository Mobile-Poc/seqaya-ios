//
//  FetchOrdersRepoPr.swift
//  seqayaPoc
//
//  Created by Mariam Elsayed Ismail on 4/10/18.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation

protocol FetchOrderReposatiry:class{
    
    func fetchOrders(Handler: @escaping ([OrderItem]) -> Void)
    
}
