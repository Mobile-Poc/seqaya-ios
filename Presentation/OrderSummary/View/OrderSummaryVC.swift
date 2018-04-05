//
//  OrderSummaryVC.swift
//  seqayaPoc
//
//  Created by Guest on 2018-03-26.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import UIKit
import Foundation
import Lottie

class OrderSummaryVC: UIViewController ,UITableViewDelegate , UITableViewDataSource , OrderSummaryViewProtocol {
   
    var presenter:OrderSummaryPresenterProtocol?
    
    func showOrderSummary(order: OrderHistory) {
        print("\(order)")
        totalOrder = order
        tableView.reloadData()
    }
    
    
    
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var deliveryTimeDate: UILabel!
    @IBOutlet weak var orderRef: UILabel!
    @IBOutlet weak var paymentLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var totalCostLabel: UILabel!
    var totalCostValue : Int = 0
    var totalOrder : OrderHistory?
    //    var orderHistory = [OrderHistoryObj]()
    //    var orderHistory2 : OrderHistoryObj?
    //    var orderSum = [OrderItem]()
    //    var orderSum2 = [Items]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backItem?.hidesBackButton = true
        self.navigationItem.setHidesBackButton(true, animated: false)
       
        tableView.register(UINib.init(nibName: "MyProductCellView" ,bundle : nil) , forCellReuseIdentifier: "productCellSummary")
       
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        presenter = OrderSummaryPresenter(view: self)
        presenter?.getPlacedOrder()
        
        
        //        HistoryNetwork().get(id:"1",completion:{(result) in
        //
        //            if result != nil {
        //                self.orderHistory = result!
        //                self.orderHistory2 = result![0]
        //
        //                if let x = self.orderHistory2{
        //                    self.orderSum2 = (x.items)
        if totalOrder != nil {
            self.paymentLabel.text = (totalOrder?.paymentMethod)!
            self.deliveryTimeDate.text = ((totalOrder?.deliveryDate)! + "," + (totalOrder?.deliveryTime)!  )
            self.addressLabel.text = (totalOrder?.location.address)!
            self.totalCostLabel.text = totalOrder?.total
            
        }
        //            }
        
    }
    
    //          self.tableView.reloadData()
    //            })
    
    //     var z =  NSLocalizedString("Shipping Details", comment: "abc")
    //    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return orderSum2.count
        if totalOrder != nil {
            return (totalOrder?.items.count)!
        }
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "productCellSummary") as? ProductSummaryCellVC {
            //  var item = (orderSum2[indexPath.row])
            if let item = (totalOrder?.items[indexPath.row]){
                cell.configureCell(name: (item.name), count: "\(item.quantity)", size: "\(item.bottleSize)", pckgSize: "\(item.no_bpp)", price: "\(item.price)" , id:"\(item.id)")
            }
            //orderedItemsCell
            return cell
        }
        return UITableViewCell()
    }
    
    //MARK:- TO FIND AN ELEMENT IN AN ARRAY OF DATA :
//    if let found = find(lazy(array).map({ $0.name }), "Foo") {
//        let obj = array[found]
//    }
    //or
//    let array = ["Apples", "Peaches", "Plums"]
//
//    if let index = array.index(of: "Peaches") {
//        print("Found peaches at index \(index)")
//    }
    
    @IBAction func doneTapped(_ sender: Any) {
        let animationView = LOTAnimationView(name: "success")
        animationView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFill
        animationView.backgroundColor = UIColor.white
        view.addSubview(animationView)
        animationView.play{ (finished) in
            //self.dismiss(animated: false, completion: nil)
            self.performSegue(withIdentifier: "unwindToCheckout", sender: nil)
        }
        
    }
}

