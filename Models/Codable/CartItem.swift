//
//  CartItem.swift
//  seqayaPoc
//
//  Created by Ahmed Fadl on 3/27/18.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation


struct CartItem:Codable  {
    let id:Int
    let name:String
    let manufacturer:String
    let bottleSize:Double
    let no_bpp:Int
    let price:Double
    let photoUrl:String
}
