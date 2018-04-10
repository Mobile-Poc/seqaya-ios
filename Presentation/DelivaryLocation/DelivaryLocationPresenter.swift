//
//  DelivaryLocationPresenter.swift
//  seqayaPoc
//
//  Created by admin101 on 4/4/18.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation

class DelivaryLocationPresenter : DelivaryLocationPresenterProtocol {
    
    weak var DelivaryLocationViewController: DelivaryLocationVcProtocol?
    
    var getLocationUsecase: GetSavedLocationUseCaseProtocol = GetSavedLocationUseCase()
    var createNewLocationUseCase: CreateNewLocationUseCaseProtocol = CreateNewLocationUseCase()


    
    required init(LocationVCProtocol: DelivaryLocationVcProtocol) {
        self.DelivaryLocationViewController = LocationVCProtocol
    }
    
    func UserSaveNewLocation(location: SavedLocation) {
        _ = createNewLocationUseCase.ExecuteUseCase(location : location) {
            
            responseDescreption in
            
        }
        
    }
    
    func GetUserSavedLocation(userEmail: String ) {
        
        getLocationUsecase.ExecuteUseCase(userEmail : userEmail) {
            location in            
            self.DelivaryLocationViewController?.ViewAllSavedLocation(locations: location)
            
        }
    }
    
}
