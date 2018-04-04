//
//  OrderItem.swift
//  seqayaPoc
//
//  Created by admin101 on 3/28/18.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation

struct OrderItem {
    
    var id:Int
    var manfucturer:String
    var name:String
    var bottleSize:Double
    var no_bpp:Int
    var price:Double
    var quantity:Int
    var photoUrl:String = ""

    init(id:Int ,name:String ,manfucturer:String, bottleSize:Double , no_bpp:Int ,price:Double , quantity:Int) {
        self.id = id
        self.manfucturer = manfucturer
        self.name = name
        self.bottleSize = bottleSize
        self.no_bpp = no_bpp
        self.price = price
        self.quantity = quantity
       
    }
    
    var dictionaryObjData : [String : Any] {
        
        var objDict = [String : Any]()
       
        objDict["id"] = self.id
        objDict["manufacturer"] = self.manfucturer
        objDict["name"] = self.name
        objDict["bottleSize"] = self.bottleSize
        objDict["price"] = self.price
        objDict["no_bpp"] = self.no_bpp
        objDict["photoUrl"] = self.photoUrl
        
        
        
        return objDict;
    }
    
    static  func orderItemsArrayToDictionary(arrayOrderItems : [OrderItem]) -> Array<Dictionary<String,Any>> {
        var arrayItemsDictionaries : Array<Dictionary<String,Any>> = Array()
        for objItem in arrayOrderItems {
            let productDict = objItem.dictionaryObjData
            let itemDict :Dictionary<String,Any> = ["product":productDict,"quantity":objItem.quantity]
            arrayItemsDictionaries.append(itemDict)
        }
        return arrayItemsDictionaries
    }

}
