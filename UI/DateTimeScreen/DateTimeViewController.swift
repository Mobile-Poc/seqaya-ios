//
//  DateTimeViewController.swift
//  seqayaPoc
//
//  Created by Yousra Ahmed on 3/26/18.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import UIKit

class DateTimeViewController: UIViewController {
    
    var orderItem:OrderHistory!
    //////////
    var deliveryDate:String!
    var deleveryTime:String!
    /////////

    var gradientLayer : CAGradientLayer!
    var timePickerData : [String] = ["٠٨:٠٠ - ١٢:٠٠","١٢:٠٠ - ١٦:٠٠ ","١٦:٠٠ - ٢٠:٠٠"]//["08:00 - 12:00","12:00 - 16:00","16:00 - 20:00"]
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timePicker: UIPickerView!
    func translateToArabic(date:String)->String{
        return date.replacingOccurrences(of: "1", with: "١").replacingOccurrences(of: "2", with: "٢").replacingOccurrences(of: "3", with: "٣").replacingOccurrences(of: "4", with: "٤").replacingOccurrences(of: "5", with: "٥").replacingOccurrences(of: "6", with: "٦").replacingOccurrences(of: "7", with: "٧").replacingOccurrences(of: "8", with: "٨").replacingOccurrences(of: "9", with: "٩").replacingOccurrences(of: "0", with: "٠")
    }
    @IBAction func datePicked(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        let strDate = dateFormatter.string(from: datePicker.date)
        dateLabel.text = translateToArabic(date:strDate)
    }
    
    @IBAction func next(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeLabel.text = timePickerData[timePicker.selectedRow(inComponent: 0)]//"١٢:٠٠ - ١٦:٠٠ "
        deleveryTime = timePickerData[timePicker.selectedRow(inComponent: 0)]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        let currentDate = Date()
        dateLabel.text = translateToArabic(date:dateFormatter.string(from: currentDate))
        deliveryDate = dateLabel.text
        var dateComponents = DateComponents()
        let calendar = Calendar.init(identifier: .gregorian)
        dateComponents.day = 0
        let minDate = calendar.date(byAdding: dateComponents, to: currentDate)
        dateComponents.day = 1000
        let maxDate = calendar.date(byAdding: dateComponents, to: currentDate)
        datePicker.minimumDate = minDate
        datePicker.maximumDate = maxDate
    
        self.timePicker.delegate = self
        self.timePicker.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //changeNavigationBar()
    }
    func image(fromLayer layer: CALayer) -> UIImage {
        UIGraphicsBeginImageContext(layer.frame.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return outputImage!
    }
    func changeNavigationBar() {
        
        let gradient = CAGradientLayer()
        let sizeLength = UIScreen.main.bounds.size.height * 2
        let defaultNavigationBarFrame = CGRect(x: 0, y: 0, width: sizeLength, height: 64)
        
        gradient.frame = defaultNavigationBarFrame
        gradient.colors = [#colorLiteral(red: 0.4274509804, green: 0.7882352941, blue: 0.9215686275, alpha: 1).cgColor,#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 0.102125671).cgColor]
        
        self.navigationController?.navigationBar.setBackgroundImage(self.image(fromLayer: gradient), for: .default)
        //UINavigationBar.appearance().setBackgroundImage(UIImage(named:"images-16"))//self.image(fromLayer: gradient), for: .default)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        orderItem.deliveryDate = deliveryDate
        orderItem.deliveryTime = deleveryTime
        let vc = segue.destination as! PaymentViewController
        vc.orderItem = orderItem
    }
    
}
extension DateTimeViewController:UIPickerViewDataSource,UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timePickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return timePickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        timeLabel.text = timePickerData[row]
        deleveryTime = timePickerData[row]
    }
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    
//    }
}
