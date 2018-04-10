//
//  UIHelper.swift
//
//  Created by Ahmed Fadl on 2/13/18.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import Foundation
import UIKit

class UIHelper{
    
    func makeCirlceImage(image: UIImageView){
        image.layer.cornerRadius = image.frame.size.height/2
        image.clipsToBounds = true
    }
    
    func makeCirlceView(view: UIView){
        view.layer.cornerRadius = view.frame.size.height/2
    }
    
    func makeCircleButton(button: UIButton){
        button.layer.cornerRadius = button.frame.size.height/2
        button.clipsToBounds = true
        
    }
    
    func resizeImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.draw(in: CGRect(origin: CGPoint.zero, size: CGSize(width: newSize.width, height: newSize.height)))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
        
    }
    
}
