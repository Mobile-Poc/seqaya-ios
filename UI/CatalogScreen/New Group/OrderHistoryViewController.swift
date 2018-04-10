//
//  OrderHistoryViewController.swift
//  seqayaPoc
//
//  Created by NTG Clarity on 3/29/18.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class OrderHistoryViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    
    @IBOutlet weak var catalogTableView: UITableView!
    
    @IBOutlet weak var searchBarButton: UIBarButtonItem!
    
    @IBOutlet weak var checkoutButton: UIButton!
    
    @IBOutlet weak var barCarButtonItem: UIBarButtonItem!
    
    @IBOutlet weak var cartButton: UIButton!
    
    var productCell:OrderHistoryCell?
    var cartItems:[CartItem]?
    var orderItems:[OrderItem] = []
    var observableCartItems = Variable<[CartItem]>([])
    var language = "ar"
    
    var cartNotification:RKNotificationHub?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        //self.cartNotification?.increment()
        self.cartNotification?.setCircleAt(CGRect(x: 20, y: -5, width: 20, height: 20))
        //self.cartNotification?.set(UIColor., labelColor: )
        catalogTableView.register(UINib.init(nibName: "OrderHistoryCell" ,bundle : nil) , forCellReuseIdentifier: "orderHistoryCell")
        ProductNetwork().get{ (result) in
            self.cartItems = result
            self.observableCartItems.value = result
            self.catalogTableView.delegate = self
            self.catalogTableView.dataSource = self
            self.catalogTableView.reloadData()
        }
        
        HistoryNetwork().get(id: "") { (result) in
            print(result)
        }
        
        
    }
    @IBAction func checkOutButtonAction(_ sender: UIButton) {
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCheakOut"
        {
            let vc = segue.destination as! CheakOutViewController
            vc.orders = orderItems
        }
    }
    
    @IBAction func sortingActionButton(_ sender: UIButton) {
        
        let actionSheetController: UIAlertController = UIAlertController(title: "ترتيب عن طريق", message: nil, preferredStyle: .actionSheet)
        
        let cancelActionButton = UIAlertAction(title: "إلغاء", style: .cancel) { _ in
            print("Cancel")
        }
        
        
        
        let sortByPrice = UIAlertAction(title: "السعر",  style: .default)
        { _ in
            
            self.cartItems = self.cartItems?.sorted(by: { cart1, cart2 in return cart1.price > cart2.price })
            self.catalogTableView.reloadData()
            
        }
        
        
        let sortByBottleSize = UIAlertAction(title: "حجم الزجاجة", style: .default)
        { _ in
            self.cartItems = self.cartItems?.sorted(by: { cart1, cart2 in return cart1.bottleSize > cart2.bottleSize })
            self.catalogTableView.reloadData()
        }
        
        let sortByBottleInPackage = UIAlertAction(title: "عدد الزجاجات في العبوة", style: .default)
        { _ in
            self.cartItems = self.cartItems?.sorted(by: { cart1, cart2 in return cart1.no_bpp > cart2.no_bpp })
            self.catalogTableView.reloadData()        }
        
        
        actionSheetController.addAction(cancelActionButton)
        actionSheetController.addAction(sortByPrice)
        actionSheetController.addAction(sortByBottleSize)
        actionSheetController.addAction(sortByBottleInPackage)
        
        present(actionSheetController, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cartItems?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = catalogTableView.dequeueReusableCell(withIdentifier: "orderHistoryCell", for: indexPath) as! OrderHistoryCell
        
        cell.nameLabel.text = self.cartItems?[indexPath.row].name
        cell.sizeLabel.text = "\(String(describing: self.cartItems![indexPath.row].bottleSize)) : الحجم"
        cell.priceLabel.text = "\(String(describing: self.cartItems![indexPath.row].price) )"
        //Setup Delegation For Product Counter Quantity
        cell.orderHistoryDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension OrderHistoryViewController:OrderHistoryCounterDelegate{
    func tapAddToCartButton(_ cell:OrderHistoryCell , quantity:Int) {
        if let index = catalogTableView.indexPath(for: cell){
            let cartItem = self.cartItems![index.row]
            if orderItems.count > 0 {
                var orderCounter = 0
                for orderItem in orderItems {
                    if cartItem.id == orderItem.id{
                        orderItems[orderCounter].quantity = orderItem.quantity + quantity
                        print(orderItems[orderCounter].quantity)
                    }
                    else{
                        orderItems.append(OrderItem(id: cartItem.id, name: cartItem.name, manfucturer: "kok", bottleSize: cartItem.bottleSize, no_bpp: cartItem.no_bpp, price: cartItem.price, quantity: quantity))
                        self.cartNotification?.increment()
                    }
                    orderCounter += 1
                }//end for order Item
            }//End else counter
            else {
                self.cartNotification?.increment()
                orderItems.append(OrderItem(id: cartItem.id, name: cartItem.name, manfucturer: "hvh", bottleSize: cartItem.bottleSize, no_bpp: cartItem.no_bpp, price: cartItem.price, quantity: quantity))
            }// End else counter
        }
    }
}
