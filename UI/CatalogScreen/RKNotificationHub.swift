//
//  RKNotifcationHub.swift
//  NotifcationHub
//
//  Created by admin101 on 3/28/18.
//  Copyright © 2018 demi. All rights reserved.
//

import Foundation
import UIKit

let RKNotificationHubDefaultDiameter: CGFloat = 30
let kCountMagnitudeAdaptationRatio: CGFloat = 0.3

let kPopStartRatio: CGFloat = 0.85
let kPopOutRatio: CGFloat = 1.05
let kPopInRatio: CGFloat = 0.95

let kBlinkDuration: Double = 0.1
let kBlinkAlpha: CGFloat = 0.1

let kFirstBumpDistance: CGFloat = 8
let kBumpTimeSeconds: Double = 0.13
let SECOND_BUMP_DIST: CGFloat = 4.0
let kBumpTimeSeconds2: Double = 0.1

class RKNotificationHub: NSObject {
    
    var hubView: UIView!
    var count: Int {
        set {
            storeCount = newValue
            countLabel.text = storeCount.description
            checkZero()
            expandToFitLargerDigits()
        }
        
        get {
            return storeCount
        }
    }
    
    fileprivate var storeCount = 0
    fileprivate var curOrderMagnitude: Int!
    fileprivate let countLabel = UILabel()
    fileprivate let redCircle = RKView()
    fileprivate var initialCenter: CGPoint!
    fileprivate var baseFrame: CGRect!
    fileprivate var initialFrame: CGRect!
    fileprivate var isIndeterminateMode: Bool!
    
    init(view: UIView) {
        super.init()
        curOrderMagnitude = 0
        let frame = view.frame
        
        isIndeterminateMode = false
        
        redCircle.isUserInteractionEnabled = false
        redCircle.isUserChangingBackgroundColor = true
        
        redCircle.backgroundColor = UIColor.red
        
        countLabel.textAlignment = .center
        countLabel.textColor = UIColor.white
        countLabel.backgroundColor = UIColor.clear
        
        setCircleAt(CGRect(x: frame.width - RKNotificationHubDefaultDiameter * 2 / 3, y: -RKNotificationHubDefaultDiameter / 3, width: RKNotificationHubDefaultDiameter, height: RKNotificationHubDefaultDiameter))
        count = 0
        view.addSubview(redCircle)
        view.addSubview(countLabel)
        view.bringSubview(toFront: redCircle)
        view.bringSubview(toFront: countLabel)
        hubView = view
        checkZero()
    }
    
    convenience init(barButtonItem: UIBarButtonItem) {
        self.init(view: (barButtonItem.value(forKey: "view") as? UIView) ?? UIView())
        scaleCircleSizeBy(0.7)
        moveCircleBy(-5, y: 0)
    }
    
    func setCircleAt(_ frame: CGRect) {
        redCircle.frame = frame
        initialCenter = CGPoint(x: frame.minX + frame.width / 2, y: frame.minY + frame.height / 2)
        baseFrame = frame
        initialFrame = frame
        countLabel.frame = redCircle.frame
        redCircle.layer.cornerRadius = frame.height / 2
        countLabel.font = UIFont(name: "HelveticaNeue", size: frame.size.width / 2)
        
        expandToFitLargerDigits()
    }
    
    func moveCircleBy(_ x: CGFloat, y: CGFloat) {
        var frame = redCircle.frame
        
        frame.origin.x += x
        frame.origin.y += y
        
        setCircleAt(frame)
    }
    
    func scaleCircleSizeBy(_ scale: CGFloat) {
        let frame = initialFrame
        let width = (frame?.width)! * scale
        let height = (frame?.height)! * scale
        let wdiff = ((frame?.size.width)! - width) / 2
        let hdiff = ((frame?.height)! - height) / 2
        
        let rect = CGRect(x: (frame?.minX)! + wdiff, y: (frame?.minY)! + hdiff, width: width, height: height)
        setCircleAt(rect)
    }
    
    func set(_ circleColor: UIColor, labelColor: UIColor) {
        redCircle.isUserChangingBackgroundColor = true
        redCircle.backgroundColor = circleColor
        countLabel.textColor = labelColor
    }
    
    func hideCount() {
        countLabel.isHidden = true
        isIndeterminateMode = true
    }
    
    func showCount() {
        isIndeterminateMode = false
        checkZero()
    }
    
    func increment() {
        count += 1
    }
    
    func decrement() {
        if 1 >= count {
            count = 0
            return
        }
        count -= 1
    }
    
    func setCountLabel(_ font: UIFont) {
        countLabel.font = UIFont(name: font.fontName, size: redCircle.frame.width / 2)
    }
    
    func pop() {
        let height = baseFrame.height
        let width = baseFrame.width
        let pop_start_h = height * kPopStartRatio
        let pop_start_w = width * kPopStartRatio
        let time_start = 0.05
        let pop_out_h = height * kPopOutRatio
        let pop_out_w = width * kPopOutRatio
        let time_out = 0.2
        let pop_in_h = height * kPopInRatio
        let pop_in_w = width * kPopInRatio
        let time_in = 0.05
        let pop_end_h = height
        let pop_end_w = width
        let time_end = 0.05
        
        let keyPath = "cornerRadius"
        
        let startSize = CABasicAnimation(keyPath: keyPath)
        startSize.duration = time_start
        startSize.beginTime = 0
        startSize.fromValue = pop_end_h / 2
        startSize.toValue = pop_start_h / 2
        startSize.isRemovedOnCompletion = false
        
        let outSize = CABasicAnimation(keyPath: keyPath)
        outSize.duration = time_out
        outSize.beginTime = time_start
        outSize.fromValue = startSize.toValue
        outSize.toValue = pop_out_h / 2
        outSize.isRemovedOnCompletion = false
        
        let inSize = CABasicAnimation(keyPath: keyPath)
        inSize.duration = time_in
        inSize.beginTime = time_start + time_out
        inSize.fromValue = outSize.toValue
        inSize.toValue = pop_in_h / 2
        inSize.isRemovedOnCompletion = false
        
        let endSize = CABasicAnimation(keyPath: keyPath)
        endSize.duration = time_end
        endSize.beginTime = time_in + time_out + time_start
        endSize.fromValue = inSize.toValue
        endSize.toValue = pop_end_h / 2
        endSize.isRemovedOnCompletion = false
        
        let group = CAAnimationGroup()
        group.duration = time_start + time_out + time_in + time_end
        group.animations = [startSize, outSize, inSize, endSize]
        
        redCircle.layer.add(group, forKey: nil)
        
        UIView.animate(withDuration: time_start, animations: { [unowned self] in
            self.setRedCircle(pop_start_h, width: pop_start_w)
            }, completion: { _ in
                UIView.animate(withDuration: time_out, animations: { [unowned self] in
                    self.setRedCircle(pop_out_h, width: pop_out_w)
                    }, completion: { _ in
                        UIView.animate(withDuration: time_in, animations: { [unowned self] in
                            self.setRedCircle(pop_in_h, width: pop_in_w)
                            }, completion: { _ in
                                UIView.animate(withDuration: time_end, animations: {
                                    self.setRedCircle(pop_end_h, width: pop_end_w)
                                })
                        })
                })
        })
    }
    
    func blink() {
        set(kBlinkAlpha)
        
        UIView.animate(withDuration: kBlinkDuration, animations: { [unowned self] in
            self.set(1)
            }, completion: { _ in
                UIView.animate(withDuration: kBlinkDuration, animations: { [unowned self] in
                    self.set(kBlinkAlpha)
                    }, completion: { _ in
                        UIView.animate(withDuration: kBlinkDuration, animations: { [unowned self] in
                            self.set(1)
                        })
                })
        })
    }
    
    func bump() {
        bumpCenter(0)
        UIView.animate(withDuration: kBumpTimeSeconds, animations: { [unowned self] in
            self.bumpCenter(kFirstBumpDistance)
            }, completion: { _ in
                UIView.animate(withDuration: kBumpTimeSeconds, animations: { [unowned self] in
                    self.bumpCenter(0)
                    }, completion: { _ in
                        UIView.animate(withDuration: kBumpTimeSeconds2, animations: { [unowned self] in
                            self.bumpCenter(SECOND_BUMP_DIST)
                            }, completion: { _ in
                                UIView.animate(withDuration: kBumpTimeSeconds2, animations: { [unowned self] in
                                    self.bumpCenter(0)
                                })
                        })
                })
        })
    }
    
    func bumpCenter(_ y: CGFloat) {
        var center = redCircle.center
        center.y = initialCenter.y - y
        redCircle.center = center
        countLabel.center = center
    }
    
    func set(_ alpha: CGFloat) {
        redCircle.alpha = alpha
        countLabel.alpha = alpha
    }
    
    func setRedCircle(_ height: CGFloat, width: CGFloat) {
        var frame = redCircle.frame
        let center = redCircle.center
        frame.size.height = height
        frame.size.width = width
        redCircle.frame = frame
        redCircle.center = center
    }
    
    func checkZero() {
        if count <= 0 {
            redCircle.isHidden = true
            countLabel.isHidden = true
        } else {
            redCircle.isHidden = false
            if !isIndeterminateMode {
                countLabel.isHidden = false
            }
        }
    }
    
    func expandToFitLargerDigits() {
        var orderOfMagnitude = CGFloat(log10(Double(count)))
        orderOfMagnitude = (orderOfMagnitude >= 2) ? orderOfMagnitude : 1
        var frame = initialFrame
        frame?.size.width = initialFrame.width * (1 + kCountMagnitudeAdaptationRatio * (orderOfMagnitude - 1))
        frame!.origin.x = initialFrame.origin.x - ((frame?.width)! - initialFrame.width) / 2
        redCircle.frame = frame!
        initialCenter = CGPoint(x: (frame?.minX)! + (frame?.width)! / 2, y: (frame?.minY)! + (frame?.height)! / 2)
        baseFrame = frame
        countLabel.frame = redCircle.frame
        curOrderMagnitude = Int(orderOfMagnitude)
    }
}

class RKView: UIView {
    var isUserChangingBackgroundColor = false
    
    override var backgroundColor: UIColor? {
        didSet {
            super.backgroundColor = backgroundColor
        }
    }
}


