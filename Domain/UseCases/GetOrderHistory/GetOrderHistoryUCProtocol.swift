//
//  GetOrderHistoryUseCase.swift
//  seqayaPoc
//
//  Created by Guest on 2018-04-05.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation
protocol GetOrderHistoryUCProtocol : class {
    
    func execute(usermail: String , historyResult: @escaping (_ history:[OrderHistoryObj])->())
    
}
