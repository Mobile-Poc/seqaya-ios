//
//  CheakOutViewController.swift
//  seqayaPoc
//
//  Created by Mariam Elsayed Ismail on 3/26/18.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import UIKit

class CheakOutViewController: UIViewController {
    
     //var orders = [OrderItem]()
    var orders =  OrderItemsSingelton.instance.orderItems
    var orderHistory: OrderHistory!
    var totalCostValue = 0

    @IBOutlet weak var stataticCostLabel: UILabel!
    @IBAction func unwindToCheckout(segue:UIStoryboardSegue){
        self.tabBarController?.tabBar.items![3].badgeValue = nil
        orders.removeAll()
        OrderItemsSingelton.instance.updateOrderItems(orders)
      //  self.tabBarController?.selectedIndex = 4
        performSegue(withIdentifier: "unwindToMain", sender: nil)
    }
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var confiirmoutlet: UIButton!
    @IBAction func confirm(_ sender: Any) {
        
        orderHistory = OrderHistory()
       
        orderHistory.items = orders
        orderHistory.total = totalCost.text
        
        performSegue(withIdentifier: "locationSegue", sender: nil)
    // perform segue to other viewcontrooler
    }
    

    @IBOutlet weak var totalCost: UILabel!
    
   
    
    @IBOutlet weak var ordersTable: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        confiirmoutlet.layer.cornerRadius = 10
        confiirmoutlet.clipsToBounds = true
//        if orders.count == 0 {
//            orders.append(OrderItem(id: 1, name: "مياه ابار", manfucturer: "نستله", bottleSize: 1.2, no_bpp: 12, price: 10, quantity: 2))
//            orders.append(OrderItem(id: 2, name: "مياه طبيعيه ", manfucturer: "دساني", bottleSize: 1.5, no_bpp: 24, price: 15, quantity: 3))
//            orders.append(OrderItem(id: 3, name: "مياه قلويه ", manfucturer: "المراعي", bottleSize: 2, no_bpp: 6, price: 20, quantity: 4))
//             orders.append(OrderItem(id: 4, name: "مياه قلويه ", manfucturer: "المراعي", bottleSize: 2, no_bpp: 6, price: 30, quantity: 5))
//             orders.append(OrderItem(id: 5, name: "مياه قلويه ", manfucturer: "المراعي", bottleSize: 2, no_bpp: 6, price: 40, quantity: 6))
//             orders.append(OrderItem(id:6, name: "مياه قلويه ", manfucturer: "المراعي", bottleSize: 2, no_bpp: 6, price: 50, quantity:7))
//        }
    
        //calculate the totalCostValue
        calculateTotalCost()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //SomeFunction
//        var orders =  OrderItemsSingelton.instance.orderItems
       orders =  OrderItemsSingelton.instance.orderItems
        calculateTotalCost()
        ordersTable.reloadData()
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DeliveryLocationVC{
            vc.orderItem = orderHistory}
       
    }
    
    
    func calculateTotalCost() {
        if orders.count == 0 {
            totalCostValue = 0
            stataticCostLabel.isHidden = true
             totalCost.text = "0"+" ريال"
             totalCost.isHidden = true
            let emptyLabel = UILabel(frame: CGRect(x:0,y:0,width: self.view.bounds.size.width, height: self.view.bounds.size.height))
            emptyLabel.text = "العربه فارغه"
            emptyLabel.font = emptyLabel.font.withSize(20)
            emptyLabel.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            emptyLabel.textAlignment = NSTextAlignment.center
            ordersTable.backgroundView = emptyLabel
            confiirmoutlet.isHidden = true
            self.tabBarController?.tabBar.items![3].badgeValue = nil
        }
        else{
        totalCostValue = 0
        stataticCostLabel.isHidden = false
        totalCost.isHidden = false
        confiirmoutlet.isEnabled = true
        confiirmoutlet.isHidden = false
        confiirmoutlet.backgroundColor = UIColor(red: 237.0/255.0, green: 144.0/255.0, blue: 95.0/255.0, alpha: 1.0)
        self.tabBarController?.tabBar.items![3].badgeValue = "\(orders.count)"
        for order in orders {
            let cost = Int(order.price) * order.quantity
            ordersTable.backgroundView = nil
            totalCostValue = totalCostValue + cost
            totalCost.text = String(totalCostValue)+" ريال"
        }
        }
    }

}
extension CheakOutViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //return cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell") as! CheakOutCell
        cell.vc = self
        cell.index = indexPath.row
        cell.productNameLabel.text = orders[indexPath.item].name
        cell.manfucturerLabel.text = orders[indexPath.item].manfucturer
        cell.botteleSize.text =  String(orders[indexPath.item].bottleSize)+" "+"لتر"
        cell.itemQuantity.text = String(orders[indexPath.item].quantity)
        cell.noOfBotteles.text = String( orders[indexPath.item].no_bpp)+" "+"زجاجه /العبوه"
        cell.productCost.text = String(orders[indexPath.item].price)+" "+" ريال"
        cell.bottleImg.image = UIImage(named:"\(self.orders[indexPath.item].id)")
        return cell
    }
}

extension CheakOutViewController :UITableViewDelegate{}
