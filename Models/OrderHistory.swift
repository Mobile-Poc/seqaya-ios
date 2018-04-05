//
//  OrderHistory.swift
//  seqayaPoc
//
//  Created by admin101 on 3/28/18.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//


import Foundation

class OrderHistory {
    private var _id:String!
    var _userId:String!
    var _items:[OrderItem]!
    var _requestDate:String!
    var _deliveryDate:String!
    var _deliveryTime:String!
    var _status:String!
    var _paymentMethod:String!
    var _location:SavedLocation!
    var _total:String!
    
    //Setters and Getters
    //sad
    
    var id:String!{
        set{
            self._id = newValue
        }
        get{
            return self._id
        }
    }
    var userId:String!{
        set{
            _userId = newValue
        }
        get{
            return _userId
        }
    }
    var items:[OrderItem]!{
        set{
            _items = newValue
        }
        get{
            return _items
        }
    }
    var requestDate:String!{
        set{
            _requestDate = newValue
        }
        get{
            return _requestDate
        }
    }
    var deliveryDate:String!{
        set{
            _deliveryDate = newValue
        }
        get{
            return _deliveryDate
        }
    }
    var deliveryTime:String!{
        set{
            _deliveryTime = newValue
        }
        get{
            return _deliveryTime
        }
    }
    
    var status:String!{
        set{
            _status = newValue
        }
        get{
            return _status
        }
    }
    var paymentMethod:String!{
        set{
            _paymentMethod = newValue
        }
        get{
            return _paymentMethod
        }
    }
    var location:SavedLocation!{
        set{
            _location = newValue
        }
        get{
            return _location
        }
    }
    var total:String!{
        set{
            _total = newValue
        }
        get{
            return _total
        }
    }
    
    
    
     static let _orderHistory = OrderHistory()
    
//    static var getInstance:OrderHistory{
//        return _orderHistory
//    }

    private init(){
        print("SINGLETON CREATED")
        //self._id = "1200"

    }
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




