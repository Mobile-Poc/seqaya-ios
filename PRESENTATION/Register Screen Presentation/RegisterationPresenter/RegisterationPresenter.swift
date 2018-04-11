//
//  RegisterationPresenter.swift
//  seqayaPoc
//
//  Created by NTG-Apple12 on 2018-04-04.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation




class RegisterationPresenter: RegisterationPresenterProtocol {

    
    weak var viewController: RegisteViewControllerProtocol!
    var postUserUseCasePro: PostUserUseCaseProtocol
    
    
    required init(registrationViewControler: RegisteViewControllerProtocol) {
        postUserUseCasePro = PostUserUseCase()
        self.viewController = registrationViewControler
    }
    
    func registeruser(name: String, email: String, password: String, phoneNumber: String) {
        postUserUseCasePro.PostUser(name: name, email: email, password: password, phoneNumber: phoneNumber, success: { (success) in
            self.viewController.registractionComplete(code: 201)
            
        }) { (error) in
            self.viewController.registractionComplete(code: 400)
        }
    }
    
    
    func CanceBtnTapped() {
        viewController.canceltapped()
    }
    
    
}

