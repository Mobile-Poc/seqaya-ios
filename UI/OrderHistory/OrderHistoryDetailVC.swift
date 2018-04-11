//
//  OrderHistoryDetailVC.swift
//  seqayaPoc
//
//  Created by Guest on 2018-03-28.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import UIKit

class OrderHistoryDetailVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
     @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var deliveryTimeDate: UILabel!
    @IBOutlet weak var orderRef: UILabel!
    @IBOutlet weak var paymentLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
      var selectedOrderHistory:OrderHistoryObj?
    var orderItem :Items?
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "productCellSummary", for: indexPath) as? ProductSummaryCellVC {
            orderItem = selectedOrderHistory?.cartItems[indexPath.row]
            cell.configureCell(name: "\(orderItem!.product.name)", count: "\(orderItem!.quantity)", size: "\(orderItem!.product.bottleSize)", pckgSize: "\(orderItem!.product.no_bpp)", price: "\(orderItem!.product.price)" ,id:"\(orderItem!.product.id)")
            
            return cell
        }
        return UITableViewCell()
    }
   
    

  
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: "MyProductCellView" ,bundle : nil) , forCellReuseIdentifier: "productCellSummary")
        tableView.delegate = self
        tableView.dataSource = self
        self.addressLabel.text = selectedOrderHistory!.location.address
        self.deliveryTimeDate.text = selectedOrderHistory!.deliveryTime
        self.paymentLabel.text = selectedOrderHistory!.paymentMethod
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let rows = selectedOrderHistory{
            return rows.cartItems.count
        }
        return 1
    }
    @IBAction func doneBtnTapped(_ sender: Any) {
        
       self.dismiss(animated: true, completion: nil)
         // self.performSegue(withIdentifier: "unwindFromHistory", sender: nil)
        
    }
    
}
