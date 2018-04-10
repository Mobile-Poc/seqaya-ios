//
//  SavedLocation.swift
//  seqayaPoc
//
//  Created by admin101 on 3/27/18.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation


struct SavedLocation :Codable  {
    var userId:String
    var address:String
    var long:Double
    var lat:Double
    
    
    init(userid: String , address:String , long : Double , lat: Double) {
        self.userId = userid
        self.address = address
        self.long = long
        self.lat = lat
    }
    
    }

