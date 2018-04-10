//
//  CheakoutNtworking.swift
//  seqayaPoc
//
//  Created by Mariam Elsayed Ismail on 3/26/18.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation
import Alamofire

class AlamaofireClient {
  
    func requestPOSTURL(url: String ,param : [String : Any] , success: @escaping (Data?) -> Void, failure: @escaping (String) -> Void){
        
        Alamofire.request(url, method: .post, parameters: param ,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                print(response)
                success(response.data)
                break
            case .failure(let error):
                let message : String
                if let httpStatusCode = response.response?.statusCode {
                    switch httpStatusCode{
                    case 400:
                        message = "bad Request"
                        print(message)
                        failure(message)
                        break
                    case 401:
                        message = "UnAuthorized"
                        print(message)
                        failure(message)
                        break
                    case 404:
                        message = "not found"
                        print(message)
                        failure(message)
                        break
                    default:
                        message = (response.response?.statusCode.description)!
                        print(message)
                        failure(message)
                        break
                    }
                }else
                {
                    print(error.localizedDescription)
                    failure(error.localizedDescription)
                    
                }
                // display alert with error message
                
            }
        }
    }
    
    func requestPOSTURL2(url: String ,param : [String : Any] , success: @escaping (Data?) -> Void, failure: @escaping (String) -> Void){
        
        Alamofire.request(url, method: .post, parameters: param ,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                if let httpStatusCode = response.response?.statusCode {
                    let message : String
                    switch httpStatusCode{
                    case 400:
                        message = "bad Request"
                        print(message)
                        failure(message)
                        break
                    case 401:
                        message = "UnAuthorized"
                        print(message)
                        failure(message)
                        break
                    case 404:
                        message = "not found"
                        print(message)
                        failure(message)
                        break
                    default:
                        success(response.data)
                        break
                    }
                    
                }
                
                
                
                
                print(response)
                //FIXME:- change response.data
                
                break
            case .failure(let error):
                let message : String
                if let httpStatusCode = response.response?.statusCode {
                    switch httpStatusCode{
                    case 400:
                        message = "bad Request"
                        print(message)
                        failure(message)
                        break
                    case 401:
                        message = "UnAuthorized"
                        print(message)
                        failure(message)
                        break
                    case 404:
                        message = "not found"
                        print(message)
                        failure(message)
                        break
                    default:
                        message = (response.response?.statusCode.description)!
                        print(message)
                        failure(message)
                        break
                    }
                }else
                {
                    print(error.localizedDescription)
                    failure(error.localizedDescription)
                    
                }
                // display alert with error message
                
            }
        }
    }
    
    func requestDELETEURL(url: String ,id : String , success: @escaping (String?) -> Void, failure: @escaping (String) -> Void){
        
        let deleteURL = "\(url)?id=\(id)"
        Alamofire.request(url, method: .delete, parameters: nil ,encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                print(response)
                success(response.description)
                break
            case .failure(let error):
                failure(error.localizedDescription)
                break
            }
        }
        
    }
    
    
    
    
    func requestGETURL(strURL: String, params: [String:String]?, success: @escaping (Data?) -> Void, failure: @escaping (NSError) -> Void) {
        
        
        Alamofire.request(strURL ,method: .get,parameters: params).responseJSON {
            (responseObject) -> Void in
            
            //print(responseObject)
            
            if responseObject.result.isSuccess {
                let jsonData = responseObject.data
                do{
                    //                         decodable protocol to decode the codable data of json data
                    //                        let result = try JSONDecoder().decode(dataDecodable.self, from: jsonData!)
                    //                        let data = result.data // returns `nil` if data is empty
                    success(jsonData)
                }
                catch (let error){
                    print("Error: \(error)")
                    failure(error as NSError)
                    
                }
            }
            if responseObject.result.isFailure {
                let error: NSError = responseObject.result.error! as NSError
                failure(error)
            }
            
        }
    }
    
    func getObject<T:Decodable> (strURL: String, params: [String:String]?, object:T , success: @escaping (T?) -> Void, failure: @escaping (NSError) -> Void) {
        
        
        Alamofire.request(strURL ,method: .get,parameters: params).responseJSON {
            (responseObject) -> Void in
            
            print(responseObject)
            
            if responseObject.result.isSuccess {
                let jsonData = responseObject.data
                do{
                    //let item =  object as! CartItem
                    let result = try JSONDecoder().decode(T.self, from: jsonData!)
                    
                    
                    // let data = result.data // returns `nil` if data is empty
                    success(result)
                }
                catch (let error){
                    print("Error: \(error)")
                    failure(error as NSError)
                    
                }
            }
            if responseObject.result.isFailure {
                let error: NSError = responseObject.result.error! as NSError
                failure(error)
            }
            
        }
    }
    
}
