//
//  ValidationHelpers.swift
//  seqayaPoc
//
//  Created by Guest on 2018-03-31.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation
class ValidationHelpers{
    func isValidEmail(testStr:String) -> Bool {
        
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        var emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        var result = emailTest.evaluate(with: testStr)
        
        return result
        
    }
}
