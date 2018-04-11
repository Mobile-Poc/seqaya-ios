//
//  OrderHistory.swift
//  seqayaPoc
//
//  Created by admin101 on 3/28/18.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//


import Foundation

struct OrderHistory {
    var id:String!
    var userId:String!
    var items:[OrderItem]!
    var requestDate:String!
    var deliveryDate:String!
    var deliveryTime:String!
    var status:String!
    var paymentMethod:String!
    var location:SavedLocation!
    var total:String!
    
    init() {
        
    }
    //    let shippingTime:String
    //    let shippingDate:String
    //    let paymentType:String
}

struct OrderHistoryObj:Codable {
    
    var userId:String!
    var cartItems:[Items]!
    var requestDate:String!
    var deliveryDate:String!
    var deliveryTime:String!
    var status:String!
    var paymentMethod:String!
    var location:SavedLocation!
//    var total:String
    
}

struct Items:Codable {

    let product:CartItem
    let quantity:Int
}

struct DeliveryLocation:Codable {
    let userId : Int
    let address: String
    let long : Double
    let lat : Double
    
}




