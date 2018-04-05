//
//  ProductFavouriteDelegate.swift
//  seqayaPoc
//
//  Created by Ahmed Fadl on 4/1/18.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//


import Foundation

protocol ProductFavouriteDelegate:class {
    func tapFaveButton(_ cell:ProductCellView , favourite:Bool)
}

