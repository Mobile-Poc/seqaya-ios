//
//  OrderHistoryCounterDelegate.swift
//  seqayaPoc
//
//  Created by NTG Clarity on 3/29/18.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation

protocol OrderHistoryCounterDelegate:class{
    func tapAddToCartButton(_ cell:OrderHistoryCell , quantity:Int)
}
