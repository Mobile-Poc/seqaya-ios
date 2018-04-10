//
//  PaymentViewController.swift
//  seqayaPoc
//
//  Created by Yousra Ahmed on 3/27/18.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController {
    
    var paymentMethod:String!
    var orderItem : OrderHistory!

    @IBOutlet weak var payTableView: UITableView!
    var paymentArr : [PaymentMethod] = [PaymentMethod("سداد","sadad"),PaymentMethod("بطاقة إئتمان","credit"),PaymentMethod("تحويل مصرفى","bank")]
    override func viewDidLoad() {
        
        print(orderItem)
        super.viewDidLoad()
        
        payTableView.delegate = self
        payTableView.dataSource = self
        payTableView.rowHeight = 100
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
extension PaymentViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pay", for:indexPath) as! PayementTableViewCell
        cell.payLabel.text = paymentArr[indexPath.row].title
        cell.iconImage.image = UIImage(named:paymentArr[indexPath.row].icon)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //perform segue
        paymentMethod = paymentArr[indexPath.row].title
        orderItem.paymentMethod = paymentMethod
        
//        OrderNewtork().post(order: orderItem, compilation: { (success) in
//            print("Post a new Order ")
//            print(success)
//        }) { (error) in
//            print("Error to Post new Order")
//            print(error)
//        }
        
        performSegue(withIdentifier: "PaymentToSummary", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        processPayment()
        
        let vc = segue.destination as! OrderSummaryVC
     //   vc.totalOrder = orderItem
        vc.navigationController?.navigationBar.backItem?.hidesBackButton = true
        
    }
    
    func processPayment(){
        OrderNewtork().post(order: orderItem, compilation: {(success) in
            print("\(success)")
        }, error: {(fail)
            in print("\(fail)")
        })
    }
    
    
}
