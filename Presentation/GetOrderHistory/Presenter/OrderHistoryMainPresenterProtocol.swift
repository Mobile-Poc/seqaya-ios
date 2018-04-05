//
//  OrderHistoryMainPresenterProtocol.swift
//  seqayaPoc
//
//  Created by Guest on 2018-04-05.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation
protocol OrderHistoryMainPresenterProtocol {
    
    var orderHistMainVC :OrderHistoryMainProtocol?{get set}

    init(vc:OrderHistoryMainProtocol)
    
    func getHistoryMain(user:String)
}
