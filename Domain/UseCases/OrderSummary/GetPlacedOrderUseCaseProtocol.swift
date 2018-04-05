//
//  GetPlacedOrderUseCaseProtocol.swift
//  seqayaPoc
//
//  Created by Guest on 2018-04-04.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation
protocol GetPlacedOrderUseCaseProtocol {
    func execute(finalPlacedOrder: @escaping (_ paymentRespone:OrderHistory)->())
}
