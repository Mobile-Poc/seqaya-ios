//
//  CheakOutViewController.swift
//  seqayaPoc
//
//  Created by Mariam Elsayed Ismail on 3/26/18.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import UIKit

protocol ShowOrderDisplayLogic: class
{
    func displayOrder(viewModel:[OrderItem])
    func displayTotal(total : String)
   
}

class CheckOutViewController: UIViewController,ShowOrderDisplayLogic {
    
   
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setUp()
    }

    
    var presenter : ShowOrderPresenter?
    var orders =  OrderItemsSingelton.instance.orderItems
    var orderHistory: OrderHistory!
    var totalCostValue = 0

    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    @IBOutlet weak var stataticCostLabel: UILabel!
    
    @IBAction func unwindToCheckout(segue:UIStoryboardSegue){
        orders.removeAll()
        presenter?.presentRemoveTapped((self.tabBarController?.tabBar.items![3])!, orders: orders)
        performSegue(withIdentifier: "unwindToMain", sender: nil)
    }
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var confiirmoutlet: UIButton!
    @IBAction func confirm(_ sender: Any) {
        
        orderHistory = OrderHistory()
        orderHistory.items = orders
        orderHistory.total = totalCost.text
        // perform segue to other viewcontrooler
        performSegue(withIdentifier: "locationSegue", sender: nil)
    
    }
    
    func displayOrder(viewModel: [OrderItem]) {
        orders = viewModel
        
        ordersTable.reloadData()
    }
    
    func displayTotal(total: String) {
    
        if Int(total) == 0 {
            
            stataticCostLabel.isHidden = true
            confiirmoutlet.isHidden = true
            totalCost.isHidden = true
            let emptyLabel = UILabel(frame: CGRect(x:0,y:0,width: self.view.bounds.size.width, height: self.view.bounds.size.height))
            emptyLabel.text = "العربه فارغه"
            emptyLabel.font = emptyLabel.font.withSize(20)
            emptyLabel.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            emptyLabel.textAlignment = NSTextAlignment.center
            ordersTable.backgroundView = emptyLabel
           // tableHeight.setValue(0.95, forKey: "Multiplier")
          
        }
        else {
           // tableHeight.setValue(0.7, forKey: "Multiplier")
            stataticCostLabel.isHidden = false
            totalCost.isHidden = false
            confiirmoutlet.isEnabled = true
            confiirmoutlet.isHidden = false
            confiirmoutlet.backgroundColor = UIColor(red: 237.0/255.0, green: 144.0/255.0, blue: 95.0/255.0, alpha: 1.0)
            totalCost.text = total + " ريال"
        }
        
    }
    
    @IBOutlet weak var totalCost: UILabel!
    
   
    
    @IBOutlet weak var ordersTable: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        confiirmoutlet.layer.cornerRadius = 10
        confiirmoutlet.clipsToBounds = true
        presenter?.getOrder()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //SomeFunction

         presenter?.getOrder()

    }
    
    func setUp(){
      
        let presenter = ShowOrderPresenter(vc:self)

        self.presenter = presenter
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DeliveryLocationVC{
            vc.orderItem = orderHistory}
       
    }
    
    func addTapped(){
        
         // update the singleTone value as saving
        presenter?.presentAddTapped(orders:orders)
        
        presenter?.getOrder()
       
    }
    
    func subTapped(){
        
        // update the singleTone value as saving and calculate total cost
        presenter?.presenetSubTapped(orders:orders)
        presenter?.getOrder()
    }
    
    func removeTapped(){
        
        // update the singleTone value as saving and calculate total cost
       
        presenter?.presentRemoveTapped( (self.tabBarController?.tabBar.items![3])!, orders:orders)
        presenter?.getOrder()
       
    }
    
    
    
    



}
extension CheckOutViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //return cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell") as! CheckOutCell
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

extension CheckOutViewController :UITableViewDelegate{}
