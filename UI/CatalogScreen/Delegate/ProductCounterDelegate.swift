//
//  ProductCounterDelegate.swift
//  seqayaPoc
//
//  Created by Ahmed Fadl on 3/27/18.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation

protocol ProductCounterDelegate:class {
    func tapAddToCartButton(_ cell:ProductCellView , quantity:Int)
}
