//
//  RegistrationPresnterProtocol.swift
//  seqayaPoc
//
//  Created by NTG-Apple12 on 2018-04-05.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation

protocol RegisterationPresenterProtocol{
    
    init (registrationViewControler:RegisteViewControllerProtocol)
    func registeruser(name: String , email:String, password:String ,phoneNumber: String)
    func CanceBtnTapped()
}
