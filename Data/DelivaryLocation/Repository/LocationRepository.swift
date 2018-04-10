//
//  LocationRepository.swift
//  seqayaPoc
//
//  Created by admin101 on 4/4/18.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation

class LocationRepository : LocationRepositoryProtocol{
    
    private final var locationNetwork = SavedLocationNetwork()

    
    func getData(userEmail: String, compilation: @escaping ([SavedLocation]) -> ()) {
        locationNetwork.get(userEmail: userEmail , compilation: { (result) in
            print("LocationRepository getData")
            compilation(result)
        })

    }
    
    func addData(location: SavedLocation, compilation: @escaping (String) -> ()) {
        
        locationNetwork.post(newlocation: location , compilation: { (result) in
            
            compilation(result)
        })
        
    }
    
    
}
