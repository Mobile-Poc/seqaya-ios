//
//  HistoryMainCell.swift
//  seqayaPoc
//
//  Created by Guest on 2018-03-28.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import UIKit

enum statusColor {
    case Delivered
    case Pending
    case Cancelled
    case In_Transit
}

extension statusColor {
    var value: UIColor {
        get {
            switch self {
            case .Delivered:
                return #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            //UIColor(red: 67/255, green: 173/255, blue: 247/255, alpha: 1.0)
            case .Cancelled:
                return UIColor.red
            case .In_Transit:
                return UIColor.orange
            case .Pending:
                return UIColor.yellow
            }
        }
    }
}
class HistoryMainCell: UITableViewCell {

    var status:String?
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var creationDate: UILabel!
    @IBOutlet weak var orderRef: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configureCell(orderStatus:String ,orderDate:String , orderPrice:String ,orderRef:String){
        
        self.orderRef.text = orderRef
        self.creationDate.text = orderDate
        self.totalPrice.text = orderPrice

        switch orderStatus
{
        case "Delivered":
             self.statusView.backgroundColor = statusColor.Delivered.value
        case "Pending":
            self.statusView.backgroundColor = statusColor.Pending.value
        case "In_Transit":
            self.statusView.backgroundColor = statusColor.In_Transit.value
        case "Cancelled":
            self.statusView.backgroundColor = statusColor.Cancelled.value
        default:
            self.statusView.backgroundColor = UIColor.gray
        }
    }

}
