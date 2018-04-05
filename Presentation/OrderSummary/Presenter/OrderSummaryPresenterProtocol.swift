//
//  pOrderSummaryPresentation.swift
//  seqayaPoc
//
//  Created by Guest on 2018-04-04.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation
protocol OrderSummaryPresenterProtocol
{
    var orderSummaryVC :OrderSummaryViewProtocol?{get set}
    
    init(view:OrderSummaryViewProtocol)
    
    func getPlacedOrder()
}
