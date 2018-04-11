//
//  Payment.swift
//  seqayaPoc
//
//  Created by admin101 on 3/29/18.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation

struct PaymentMethod{
    let title: String
    let icon: String
    init(_ title:String,_ icon:String){
        self.title = title
        self.icon = icon
    }
}
