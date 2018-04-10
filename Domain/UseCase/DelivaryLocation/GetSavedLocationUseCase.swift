//
//  GetSavedLocationUseCase.swift
//  seqayaPoc
//
//  Created by admin101 on 4/4/18.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation

struct GetSavedLocationUseCase : GetSavedLocationUseCaseProtocol {
    
    var locationRepProtocol: LocationRepositoryProtocol
    
    init() {
        locationRepProtocol = LocationRepository()
    }
    
    func ExecuteUseCase(userEmail: String, compilation: @escaping ([SavedLocation]) -> ()) {
        
        _ = locationRepProtocol.getData(userEmail : userEmail) {
            location in
            print("GetSavedLocationUseCase called")
            compilation(location)
            
        }
        
    }
    
  
}
