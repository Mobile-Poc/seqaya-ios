//
//  FavProductViewController.swift
//  seqayaPoc
//
//  Created by Ahmed Fadl on 4/1/18.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import UIKit

class FavProductViewController: UIViewController {
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var cartItems:[CartItem]?
    var favouritesItem:[CartItem] = []
    
    @IBOutlet weak var favTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.cartItems = appDelegate.cartItems
        //
        ProductNetwork().get{ (result) in
            self.cartItems = result
            self.getAllFavourites()
        }
        
        self.favTableView.register(UINib.init(nibName: "ProductCellView" ,bundle : nil) , forCellReuseIdentifier: "productCellView")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.cartItems != nil {
            self.getAllFavourites()
        }
    }
    
    func getAllFavourites(){
        favouritesItem.removeAll()
        
        for cart in cartItems!{
            print("product id : \(UserDefaults.standard.integer(forKey: "\(cart.id)") as? Int)")
            if let id = (UserDefaults.standard.integer(forKey: "\(cart.id)") as? Int){
                if cart.id == id{
                    favouritesItem.append(cart)
                }
            }
            self.favTableView.reloadData()
            self.favTableView.delegate = self
            self.favTableView.dataSource = self
        }
    }
}

extension FavProductViewController:UITableViewDelegate , UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouritesItem.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = favTableView.dequeueReusableCell(withIdentifier: "productCellView", for: indexPath) as! ProductCellView
        
        let productFav = UserDefaults.standard.integer(forKey: "\(self.favouritesItem[indexPath.row].id)")
        if productFav > 0 {
            cell.loveButton.setImage(UIImage.init(named: "blueHeart"), for: UIControlState.normal)
        }else{             cell.loveButton.setImage(UIImage.init(named: "emptyHeart"), for: UIControlState.normal)
        }
        cell.nameLabel.text = self.favouritesItem[indexPath.row].name
        cell.sizeLabel.text = "\(String(describing: self.favouritesItem[indexPath.row].bottleSize)) : الحجم"
        cell.manufcturerNameLabel.text = self.favouritesItem[indexPath.row].manufacturer
        cell.priceLabel.text = "\(String(describing: self.favouritesItem[indexPath.row].price) ) ريال"
        cell.numberOfButtleLabel.text = "\(self.favouritesItem[indexPath.row].no_bpp)"
        //Delegatation
        cell.productDelegate = self
        cell.favouriteDelegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FavProductViewController:ProductCounterDelegate{
    func tapAddToCartButton(_ cell:ProductCellView , quantity:Int) {
        print("tap button from FavList")
        
        var  orderItems = OrderItemsSingelton.instance.orderItems
        
        if let favIndex = favTableView.indexPath(for: cell){
            let cartItem = self.favouritesItem[favIndex.row]
            var isexist = false
            if var x = orderItems.index(where:{ $0.id == cartItem.id
            }){
                var newQuantity = orderItems[x].quantity + quantity
                OrderItemsSingelton.instance.updateItemQuant(newQuantity, indx: x)
                isexist = true
                
            }else{
                OrderItemsSingelton.instance.appendNewItem(OrderItem(id: cartItem.id, name: cartItem.name, manfucturer: cartItem.manufacturer, bottleSize: cartItem.bottleSize, no_bpp: cartItem.no_bpp, price: cartItem.price, quantity: quantity))
            }
            
            self.tabBarController?.tabBar.items![3].badgeValue = "\(OrderItemsSingelton.instance.orderItems.count)"
        }
    }
}


extension FavProductViewController : ProductFavouriteDelegate {
    func tapFaveButton(_ cell: ProductCellView, favourite: Bool) {
        let prefs = UserDefaults.standard
        if let index = favTableView.indexPath(for: cell){
            print("Delete Fav With Name: \(self.favouritesItem[index.row].name)")
            let cartItemId = self.favouritesItem[index.row].id
            print(cartItemId)
            if (favourite == false){
                prefs.removeObject(forKey: "\(cartItemId)")
                favouritesItem.remove(at: index.row)
                favTableView.reloadData()
            }
        }
    }
}
