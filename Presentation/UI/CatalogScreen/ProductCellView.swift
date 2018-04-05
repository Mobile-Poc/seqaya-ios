//
//  ProductCellView.swift
//  seqayaPoc
//
//  Created by Ahmed Fadl on 3/26/18.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import UIKit

class ProductCellView: UITableViewCell, CatalogFavButtonDelegate {
    
    @IBOutlet weak var manufcturerNameLabel: UILabel!
    
    @IBOutlet weak var waterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    
    @IBOutlet weak var numberOfButtleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var subtractButton:
    UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var productCounteTextField: UITextField!
    @IBOutlet weak var AddToCartButton: UIButton!
    @IBOutlet weak var loveButton: UIButton!
    var flag = false
    var counter:Int = 1
    //var cardItem :CartItem = CartIte
    
    weak var  productDelegate : ProductCounterDelegate?
    weak var favouriteDelegate:ProductFavouriteDelegate?
    var catalogViewController: CatalogViewController?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        UIHelper().makeCircleButton(button: plusButton)
        UIHelper().makeCircleButton(button: subtractButton)
        UIHelper().makeCircleButton(button: AddToCartButton)
        productCounteTextField.addTarget(self, action:#selector(textFieldDidChange(textField:)), for: .editingChanged)
        //loveButton.tag = 0
        //catalogViewController?.catalogFavButtonDelegate = self
    }
    
    override func layoutSubviews() {
        catalogViewController?.catalogFavButtonDelegate = self
    }
    
    
    
    @objc func textFieldDidChange(textField: UITextField){
            if textField.text != "" {  //&& textField.text != nil
                counter = Int(textField.text!)!
                if(textField.text == "0" ){
                    AddToCartButton.isEnabled = false
                }else{
                    AddToCartButton.isEnabled = true
                }
                
            }
            else{
                AddToCartButton.isEnabled = false
        }
        print("Text changed")
        
    }
    
    
    @IBAction func plusActionButton(_ sender: UITextField) {
        counter += 1
        productCounteTextField.text = "\(counter)"
    }
    
    @IBAction func subtractActionButton(_ sender: UIButton) {
        if counter > 1 {
            counter -= 1
            productCounteTextField.text = "\(counter)"
        }
    }
    
    
    @IBAction func loveButtonAction(_ sender: UIButton) {
        //flag = true
        if loveButton.currentImage == UIImage(named: "blueHeart") {
            print("ok")
            //loveButton.image(for: .normal) == "blueHeart"
            loveButton.setImage(UIImage.init(named: "emptyHeart"), for: UIControlState.normal)
            favouriteDelegate?.tapFaveButton(self, favourite: false)
            //blueHeart
            
        }
            
        else{
            loveButton.setImage(UIImage.init(named: "blueHeart"), for: UIControlState.normal)
            favouriteDelegate?.tapFaveButton(self, favourite: true)
        }
    }
    
    @IBAction func AddToCartActionButton(_ sender: UIButton) {
        if ( productCounteTextField.text == "")
        {
            productCounteTextField.text = "1"
        }
        let productQuantity = Int(productCounteTextField.text!)
        self.productDelegate?.tapAddToCartButton(self , quantity: productQuantity!)
        counter = 1
        productCounteTextField.text = "\(counter)"
    }
    
    func catalogTapFaveButton(favourite: Bool) {
        print("Catalog Fav Button : \(favourite)")
        self.flag = favourite
    }
    
    
}
