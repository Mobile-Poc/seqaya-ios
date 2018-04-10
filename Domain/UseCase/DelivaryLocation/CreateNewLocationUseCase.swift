//
//  CreateNewLocationUseCase.swift
//  seqayaPoc
//
//  Created by admin101 on 4/4/18.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation

struct CreateNewLocationUseCase : CreateNewLocationUseCaseProtocol {
   
    
    var locationRepProtocol: LocationRepositoryProtocol
    
    init() {
        
        locationRepProtocol = LocationRepository()
    }
    func ExecuteUseCase(location: SavedLocation, compilation: @escaping (String) -> ()) {
        _ = locationRepProtocol.addData(location : location) {
            
            responseDescreption in
            
            compilation(responseDescreption)
            
        }
    }

}
