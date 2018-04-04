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
    
    required init(view: OrderSummaryViewProtocol) {
        orderSummaryVC = view
    }
    
    func getPlacedOrder() {
        //some function that calls r
    }
    
    
}
