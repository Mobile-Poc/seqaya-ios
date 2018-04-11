//
//  GetSavedLocationUseCaseProtocol.swift
//  seqayaPoc
//
//  Created by admin101 on 4/4/18.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation

protocol GetSavedLocationUseCaseProtocol {
    
    func ExecuteUseCase(userEmail: String , compilation: @escaping ([SavedLocation]) -> ())
}
