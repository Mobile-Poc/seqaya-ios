//
//  OrderHistoryMainVC.swift
//  seqayaPoc
//
//  Created by Guest on 2018-03-28.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import UIKit
//uiview.appearance.semantic uicementic force right to left

class OrderHistoryMainVC: UIViewController,UITableViewDelegate , UITableViewDataSource {
    
    var orderHistory = [OrderHistoryObj]()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        refreshHistory()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        refreshHistory()
        tableView.reloadData()
    }
    
    func refreshHistory(){
        let usermail = UserDefaults.standard.object(forKey: "email") as! String ?? ""
        HistoryNetwork().get(id: usermail, completion: {(result)
            in
            if result != nil {
                self.orderHistory = result!
                //self.orderHistory2 = result[0]
                self.tableView.reloadData()
            }
        })
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryMainCell", for: indexPath) as? HistoryMainCell{
            let order = orderHistory[indexPath.row]
            let total = calculateTotalCost(order: order.cartItems)
            
            cell.configureCell(orderStatus: order.status, orderDate: order.requestDate, orderPrice: "\(total) ريال", orderRef: "50000")
            return cell
        }
        return UITableViewCell()
    }
    
    func calculateTotalCost(order:[Items])->(Int) {
        if order.count == 0 {
            return 0
        }
        else{
            var totalCostValue = 0
            for orderItem in order {
                let cost = Int(orderItem.product.price) * orderItem.quantity
                totalCostValue = totalCostValue + cost
                
            }
            return (totalCostValue)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderHistory.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "orderDetailSegue", sender: orderHistory[indexPath.row])
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "orderDetailSegue" {
                if let targetController = segue.destination as? OrderHistoryDetailVC{
                    if let item = sender as? OrderHistoryObj {
                        targetController.selectedOrderHistory = item
                    }
                }
            }
        }
        
    }
}
