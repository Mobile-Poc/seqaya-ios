//
//  CheakOutPresenter.swift
//  seqayaPoc
//
//  Created by Mariam Elsayed Ismail on 4/4/18.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation
import UIKit

protocol ShowOrderPresentationLogic : class
{
    func presentOrder(response: [OrderItem])
    func presentupdateCart(newValue : Int)  // work of interactor in Vip
    func presentAddTapped(orders:[OrderItem])
    func presenetSubTapped(orders:[OrderItem])
    func presentRemoveTapped(_ ref : UITabBarItem,orders:[OrderItem])
    func presentTotal(total:String)
}

class ShowOrderPresenter: ShowOrderPresentationLogic
{
    weak var viewController: ShowOrderDisplayLogic?
    var totalCostValue : Int!
    var orders = [OrderItem]()
    
    init(vc : ShowOrderDisplayLogic ) {
        
        self.viewController = vc
    }
   
   
    
    
    // MARK: - Fetch order
    
    func getOrder()
    {
     
        
        FetchOrdersUseCase(presenter:self).fetchOrders()
    }
    
   
    // MARK: - Fetch order
    
    func presentOrder(response: [OrderItem])
    {
       orders = response
      
        viewController?.displayOrder(viewModel: response)
        calculateTotalCost()
    }
    
   
    func presentupdateCart(newValue: Int) {  // work of interactor in Vip
        
    }
    
    func presentTotal(total:String) {
       
        viewController?.displayTotal(total:total)
    }
    
    func presenetSubTapped(orders:[OrderItem]){
        // 1-Upadte SingleTone VAr
        UpdateOrderUseCase().updateOrder(orders)
    }
    
    func presentAddTapped(orders:[OrderItem]) {
        
        // 1-Upadte SingleTone VAr
        UpdateOrderUseCase().updateOrder(orders)
        
        
    }
    
    func presentRemoveTapped(_ ref : UITabBarItem,orders:[OrderItem]) {
        // 1-Upadte SingleTone VAr
       UpdateOrderUseCase().updateOrder(orders)
        //3- update Cart
       ref.badgeValue = String(orders.count)
    }
    
    
    func calculateTotalCost() {
      
        if orders.count == 0 {
            totalCostValue = 0
           presentTotal(total: String(totalCostValue))
           // self.tabBarController?.tabBar.items![3].badgeValue = nil
        }
        else{
            totalCostValue = 0
           
//            self.tabBarController?.tabBar.items![3].badgeValue = "\(orders.count)"
            
         for order in orders {
                let cost = Int(order.price) * order.quantity
            
                totalCostValue = totalCostValue + cost
                presentTotal(total: String(totalCostValue))
            }
        }
    }

    
  
    
}
