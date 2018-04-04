//
//  SavedLocationModel.swift
//  seqayaPoc
//
//  Created by admin101 on 3/27/18.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation

class SavedLocationModel:Codable{
    
    var locationName : String?
    var locationLatitude : Double?
    var locationLongitude : Double?
    
    init(name: String , latitude: Double , longitude: Double) {
        locationName = name
        locationLatitude = latitude
        locationLongitude = longitude
    }
}
