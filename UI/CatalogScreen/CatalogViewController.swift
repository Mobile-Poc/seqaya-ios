//
//  CatalogViewController.swift
//  seqayaPoc
//
//  Created by Ahmed Fadl on 3/26/18.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import MBProgressHUD
class CatalogViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    
    @IBAction func backToMainUnWind(segue:UIStoryboardSegue){
        self.tabBarController?.tabBar.items![3].badgeValue = nil
        orderItems.removeAll()
         OrderItemsSingelton.instance.updateOrderItems(orderItems)
        orderItemFlag = false
    }
    @IBOutlet weak var catalogTableView: UITableView!
    
    @IBOutlet weak var searchBarButton: UIBarButtonItem!
    
    @IBOutlet weak var checkoutButton: UIButton!
    
//    @IBOutlet weak var barCarButtonItem: UIBarButtonItem!
    
    @IBOutlet weak var cartButton: UIButton!
    
    @IBOutlet weak var addToCartButton: UIButton!
    
    var orderItemFlag = false
    
    var productCell:ProductCellView?
    var pr = ProductCellView()
    var cartItems:[CartItem]?
    var orderItems:[OrderItem] = OrderItemsSingelton.instance.orderItems
    var observableCartItems = Variable<[CartItem]>([])
    var language = "ar"
    
//    var cartNotification:RKNotificationHub?
    weak var catalogFavButtonDelegate:CatalogFavButtonDelegate?
    
    override func viewDidLoad() {
        
//        self.cartNotification = RKNotificationHub(barButtonItem: barCarButtonItem)
//        self.barCarButtonItem.isEnabled = false
        //self.cartNotififadfcation?.increment()
//        self.cartNotification?.setCircleAt(CGRect(x: 20, y: -5, width: 20, height: 20))
        //self.cartNotification?.set(UIColor., labelColor: <#T##UIColor#>)
        catalogTableView.register(UINib.init(nibName: "ProductCellView" ,bundle : nil) , forCellReuseIdentifier: "productCellView")
        //self.hideKeyboardAll()
        self.showHud("تحميل...")
        ProductNetwork().get{ (result) in
            self.cartItems = result
            self.observableCartItems.value = result
            self.catalogTableView.delegate = self
            self.catalogTableView.dataSource = self
            self.catalogTableView.reloadData()
            self.hideHUD()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
         self.tabBarController?.tabBar.items![3].badgeColor = UIColor(red: 255.0/255.0, green: 169.0/255.0, blue: 64.0/255.0, alpha: 1.0)
      
        if(!(OrderItemsSingelton.instance.orderItems.count > 0)){
            self.tabBarController?.tabBar.items![3].badgeValue = nil
            orderItemFlag = true
        }else{
            var orderCounter = OrderItemsSingelton.instance.orderItems.count
                 self.tabBarController?.tabBar.items![3].badgeValue = "\(orderCounter)"
                    }
        
        self.catalogTableView.reloadData()
       }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func checkOutButtonAction(_ sender: UIButton) {
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (orderItemFlag == false || !(OrderItemsSingelton.instance.orderItems.count > 0)){
            
            let alert = UIAlertController(title: "خطآ", message: "عربة التسوق فارغة", preferredStyle: UIAlertControllerStyle.alert)
            
            let alertCancel = UIAlertAction(title: "إلغاء", style: UIAlertActionStyle.cancel, handler: nil)
            
            alert.addAction(alertCancel)
            present(alert, animated: true, completion: nil)
            
        }else{
            if segue.identifier == "showCheakOut"
            {
                let vc = segue.destination as! CheakOutViewController
               // vc.orders = orderItems
                
            }
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
        let cell = catalogTableView.dequeueReusableCell(withIdentifier: "productCellView", for: indexPath) as! ProductCellView
        
        let productFav = UserDefaults.standard.integer(forKey: "\(self.cartItems![indexPath.row].id)")
        if productFav > 0 {
                cell.loveButton.setImage(UIImage.init(named: "blueHeart"), for: UIControlState.normal)
        }else{             cell.loveButton.setImage(UIImage.init(named: "emptyHeart"), for: UIControlState.normal)
        }
        
        cell.nameLabel.text = self.cartItems?[indexPath.row].name
        cell.sizeLabel.text = "\(String(describing: self.cartItems![indexPath.row].bottleSize))" + " "+"لتر"
        cell.manufcturerNameLabel.text = self.cartItems?[indexPath.row].manufacturer
        cell.priceLabel.text = "\(String(describing: self.cartItems![indexPath.row].price) ) ريال"
        cell.numberOfButtleLabel.text = "\(self.cartItems![indexPath.row].no_bpp)"+" "+"زجاجه /العبوه"
        cell.waterImage.image = UIImage(named:"\((self.cartItems?[indexPath.row].id ?? 1) )")
        
        //Setup Delegation For Product Delegate
        cell.productDelegate = self
        cell.favouriteDelegate = self
        //End Delegation
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CatalogViewController:ProductCounterDelegate{
    func tapAddToCartButton(_ cell:ProductCellView , quantity:Int) {
        orderItems = OrderItemsSingelton.instance.orderItems
        orderItemFlag = true
        if let index = catalogTableView.indexPath(for: cell){
            
            let cartItem = self.cartItems![index.row]
            var orderCounter = 0
            if orderItems.count > 0 {
                var isexist = false
                
                for orderItem in orderItems {
                    if cartItem.id == orderItem.id{
                        orderItems[orderCounter].quantity = orderItem.quantity + quantity
                        OrderItemsSingelton.instance.updateOrderItems(orderItems)
                        print(orderItems[orderCounter].quantity)
                        isexist = true
                    }
                  
                    orderCounter += 1
                }//end for order Item
                
                if !isexist{
                    orderItems.append(OrderItem(id: cartItem.id, name: cartItem.name, manfucturer: cartItem.manufacturer, bottleSize: cartItem.bottleSize, no_bpp: cartItem.no_bpp, price: cartItem.price, quantity: quantity))
                    
                    OrderItemsSingelton.instance.updateOrderItems(orderItems)
//                    self.cartNotification?.increment()
                    let cnt:Int?
                    if let val = (self.tabBarController?.tabBar.items![3].badgeValue) {
                        cnt = Int(val)
                        self.tabBarController?.tabBar.items![3].badgeValue = "\(cnt!+1)"
                    }
                    
                    
                }
                
            }//End else counter
            else {
//                self.cartNotification?.increment()
                 self.tabBarController?.tabBar.items![3].badgeValue = "\(1)"
                orderItems.append(OrderItem(id: cartItem.id, name: cartItem.name, manfucturer: cartItem.manufacturer, bottleSize: cartItem.bottleSize, no_bpp: cartItem.no_bpp, price: cartItem.price, quantity: quantity))
                 OrderItemsSingelton.instance.updateOrderItems(orderItems)
            }// End else counter
        }
        
        
        
    }
    @IBAction func SearchButton(_ sender: UIBarButtonItem) {
        searchController()
    }
}
extension CatalogViewController :  UISearchBarDelegate , UISearchResultsUpdating{
    
    
    func searchController (){
        let controller = UISearchController(searchResultsController: nil)
        controller.delegate = self as? UISearchControllerDelegate
        controller.searchBar.delegate = self
        controller.searchResultsUpdater = self
        controller.dimsBackgroundDuringPresentation = false
        controller.hidesNavigationBarDuringPresentation = false
        controller.searchBar.keyboardType = UIKeyboardType.asciiCapable
        controller.searchBar.sizeToFit()
        controller.searchBar.placeholder = "ابحث هنا"
        controller.searchBar.setValue("الغاء", forKey: "_cancelButtonText")
        present(controller, animated: true, completion: nil)
    }
    
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let bag = DisposeBag()
        let Showitems = Variable<[CartItem]>([])
        
        
        Observable.combineLatest(self.observableCartItems.asObservable(), searchController.searchBar.rx.text, resultSelector: { items, text in
            return items.filter{ item -> Bool in
                if (item.name.lowercased().range(of: text!.lowercased()) != nil)
                {
                    return true
                }
                return false
            }
        }).throttle(1, scheduler: MainScheduler.instance).bind(to: Showitems).disposed(by: bag)
        
        Showitems.asObservable().subscribe(onNext: {values in
            
            self.cartItems = values
            self.catalogTableView.reloadData()
        }).disposed(by: bag)
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.viewDidLoad()
        
    }
}

extension CatalogViewController:ProductFavouriteDelegate{
    
    func tapFaveButton(_ cell: ProductCellView, favourite: Bool) {
        let prefs = UserDefaults.standard
        if let index = catalogTableView.indexPath(for: cell){
            
            
            print(self.cartItems![index.row].name)
            
            let cartItemId = self.cartItems![index.row].id
            if (favourite == true){
                prefs.set(cartItemId, forKey: "\(cartItemId)")
            }else{
                let prefs = UserDefaults.standard
                prefs.removeObject(forKey: "\(cartItemId)")
            }
        }
    }
}

