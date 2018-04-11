//
//  OrderSummaryRepositoryProtocol.swift
//  seqayaPoc
//
//  Created by Guest on 2018-04-04.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation
protocol OrderSummaryRepositoryProtocol {
    func getPlacedOrder(completion: @escaping (OrderHistory) -> ())
}
