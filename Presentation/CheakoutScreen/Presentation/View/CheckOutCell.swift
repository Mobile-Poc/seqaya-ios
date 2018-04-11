//
//  CheckOutCell.swift
//  seqayaPoc
//
//  Created by Mariam Elsayed Ismail on 3/27/18.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import UIKit

class CheckOutCell: UITableViewCell {

   weak var vc : CheckOutViewController!
    weak var catVc : CatalogViewController!
    @IBOutlet weak var bottleImg: UIImageView!
    var index : Int!
    
    @IBAction func removeItem(_ sender: UIButton) {
        
        vc.orders.remove(at: index)
        
       // OrderItemsSingelton.instance.updateOrderItems(vc.orders)
       // vc.calculateTotalCost()
       vc.removeTapped()
        
    }
    @IBAction func subQuantit(_ sender: Any) {
        let int = Int(itemQuantity.text!)!-1
        
        if itemQuantity.text == "2" {
             subButton.isHidden = true
           // OrderItemsSingelton.instance.updateOrderItems(vc.orders)
           // vc.calculateTotalCost()
        }
        itemQuantity.text = String(int)
        vc.orders[index].quantity = int
        vc.subTapped()
    }
    @IBAction func addQuanti(_ sender: Any) {
        subButton.isHidden = false
        let int = Int(itemQuantity.text!)!+1
        itemQuantity.text = String(int)
       vc.orders[index].quantity = int
        vc.addTapped()
    }
    @IBOutlet weak var subButton: UIButton!
    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBOutlet weak var manfucturerLabel: UILabel!
    
    @IBOutlet weak var botteleSize: UILabel!
    
    @IBOutlet weak var noOfBotteles: UILabel!
    
    @IBOutlet weak var productCost: UILabel!
    
    @IBOutlet weak var itemQuantity: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
