//
//  Product.swift
//  seqayaPoc
//
//  Created by Ahmed Fadl on 3/26/18.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation

class Product {
    
    var name:String?
    var size:String?
    var price:Double?
    var image:String?
    
    init(name:String , size:String , price:Double , image:String) {
        self.name = name
        self.size = size
        self.price = price
        self.image = image
    }
    
    
}
