//
//  CheakOutModel.swift
//  seqayaPoc
//
//  Created by Mariam Elsayed Ismail on 3/26/18.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation

struct CheckOutProduct {
    
    let id : Int
    let name :String
    let manfucturer : String
    let botteleSize : Double
    let bottelesInPack : Int
    let price : Double
    
    init(id:Int,name :String,manfucturer:String,botteleSize : Double,bottelesInPack : Int,price : Double) {
        
        self.id = id
        self.name = name
        self.manfucturer = manfucturer
        self.botteleSize = botteleSize
        self.bottelesInPack = bottelesInPack
        self.price = price
    }
}

