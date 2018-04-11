//
//  ProductSummaryCellVC.swift
//  seqayaPoc
//
//  Created by Guest on 2018-03-28.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import UIKit

class ProductSummaryCellVC: UITableViewCell {

    
    

    @IBOutlet weak var countView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var sizeLabel: UILabel!
    
    @IBOutlet weak var packetSizeLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var productCountLabel: UILabel!
    
    @IBOutlet weak var productImage:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       // UIHelper().makeCirlceView(view: countView)
    }
    
    func configureCell(name:String ,count:String,size:String,pckgSize:String ,price:String,id:String){
        nameLabel.text = name
        productCountLabel.text = count
        priceLabel.text = price + " " + "ريال"
        sizeLabel.text = size+" "+"لتر"
        packetSizeLabel.text = pckgSize+" "+"زجاجه /العبوه"
        productImage.image = #imageLiteral(resourceName: id)
        
    }
    
    
}
