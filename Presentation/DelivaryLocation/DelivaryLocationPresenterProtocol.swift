//
//  DelivaryLocationPresenterProtocol.swift
//  seqayaPoc
//
//  Created by admin101 on 4/4/18.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation
protocol DelivaryLocationPresenterProtocol {
    
    init(LocationVCProtocol:DelivaryLocationVcProtocol)
    func UserSaveNewLocation(location: SavedLocation)
    func GetUserSavedLocation(userEmail: String)
    
}
