//
//  OrderHistoryCellTableViewCell.swift
//  seqayaPoc
//
//  Created by NTG Clarity on 3/29/18.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import UIKit

class OrderHistoryCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var subtractButton:
    UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var productCounterLabel: UILabel!
    @IBOutlet weak var AddToCartButton: UIButton!
    @IBOutlet weak var loveButton: UIButton!
    var flag = false
    var counter:Int = 0
    //var cardItem :CartItem = CartIte
    
    weak var  orderHistoryDelegate : OrderHistoryCounterDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        UIHelper().makeCircleButton(button: plusButton)
        UIHelper().makeCircleButton(button: subtractButton)
        UIHelper().makeCircleButton(button: AddToCartButton)
    }
    
    @IBAction func plusActionButton(_ sender: UIButton) {
        counter += 1
        productCounterLabel.text = "\(counter)"
    }
    
    @IBAction func subtractActionButton(_ sender: UIButton) {
        if counter > 0 {
            counter -= 1
            productCounterLabel.text = "\(counter)"
        }
    }
    
    
    @IBAction func loveButtonAction(_ sender: UIButton) {
        //flag = true
        if flag == false {
            loveButton.setImage(UIImage.init(named: "emptyLove"), for: UIControlState.normal)
            flag = true
            //blueHeart
        }
        else{
            loveButton.setImage(UIImage.init(named: "blueHeart"), for: UIControlState.normal)
            flag = false
        }
    }
    
    @IBAction func AddToCartActionButton(_ sender: UIButton) {
        let productQuantity = Int(productCounterLabel.text!)
        //self.orderHistoryDelegate?.tapAddToCartButton(self , quantity: productQuantity!)
        counter = 0
        productCounterLabel.text = "\(counter)"
    }
    
    
}
