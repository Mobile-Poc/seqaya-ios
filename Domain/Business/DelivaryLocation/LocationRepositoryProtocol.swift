//
//  LocationRepositoryProtocol.swift
//  seqayaPoc
//
//  Created by admin101 on 4/4/18.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation


protocol LocationRepositoryProtocol {
    
    func getData(userEmail: String , compilation: @escaping ([SavedLocation]) -> ())
    func addData(location: SavedLocation , compilation: @escaping (String) -> ())
    
}
