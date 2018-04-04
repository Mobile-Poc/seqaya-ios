//
//  OrderNetwork.swift
//  seqayaPoc
//
//  Created by Ahmed Fadl on 3/29/18.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation
import Alamofire

class OrderNewtork{
    let alamaofireClient = AlamaofireClient()
    
    func post(order: OrderHistory , compilation: @escaping (Data) -> () , error: @escaping (String) -> ()) {
        let url = "http://mesawer.getsandbox.com/order"
        //\(Date())
        
        let usermail = UserDefaults.standard.object(forKey: "email") as! String ?? ""
        
        
        let dict:Dictionary<String,Any> = [
            "userId" : usermail,
                "address" : order.location.address,
            "long" : order.location.long,
            "lat" : order.location.lat
            
            ]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let datenew = dateFormatter.string(from: Date())

      
        let params:Parameters = ["id":arc4random_uniform(1000) ,
                                 "userId": usermail ,
                                 "cartItems": OrderItem.orderItemsArrayToDictionary(arrayOrderItems: order.items!)   ,
             "requestDate":"\(datenew)" as String,
             "deliveryDate":order.deliveryDate ?? "" ,
              "deliveryTime":order.deliveryTime  ?? "",
              "paymentMethod":order.paymentMethod!,
              "location":dict ,//order.location! as NSDictionary,
              "status":"Delivered" 
        ] // as [String : Any]
        
        alamaofireClient.requestPOSTURL(url: url, param: params, success: {
            (success) in
            compilation(success!)
            
        }){
            (failure) in
            error(failure)
            } 
        }
        
    }

