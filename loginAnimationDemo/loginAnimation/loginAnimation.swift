//
//  LoginAnimation.swift
//  
//
//  Created by Kiss-shot Acerola-orion Heart-under-blade on 15/1/15.
//  Copyright (c) 2015年 PX. All rights reserved.
//

import UIKit

class loginAnimationView: UIView
{

    @IBOutlet weak var originLeftHand: UIImageView!
    @IBOutlet weak var originRightHand: UIImageView!
    @IBOutlet weak var leftArm: UIImageView!
    @IBOutlet weak var rightArm: UIImageView!
    @IBOutlet weak var armView: UIView!
    
    lazy var offsetLX:CGFloat = 0.0
    lazy var offsetLY:CGFloat = 0.0
    lazy var offsetRX:CGFloat = 0.0
    lazy var offsetRY:CGFloat = 0.0

    override func awakeFromNib()
    {
        offsetLX = leftArm.frame.origin.x + leftArm.superview!.frame.origin.x - originLeftHand.frame.origin.x
        offsetLY = (leftArm.frame.origin.y + leftArm.superview!.frame.origin.y - originLeftHand.frame.origin.y) * 0.5
        
        offsetRX = leftArm.frame.origin.x + leftArm.superview!.frame.origin.x - originLeftHand.frame.origin.x - 8
        offsetRY = offsetLY
        
        leftArm.transform = CGAffineTransformMakeTranslation(-offsetLX, -offsetLY)
        rightArm.transform = CGAffineTransformMakeTranslation(offsetRX, -offsetRY)
    }
    func setAnimation(isCoverEye:Bool)
    {
        unowned let WeakS = self
        if(isCoverEye)
        {
            loginAnimationView.animateWithDuration(0.5, animations: { () -> Void in
                WeakS.rightArm.transform = CGAffineTransformMakeTranslation(0, 0)
                WeakS.leftArm.transform = CGAffineTransformMakeTranslation(0, 0)
                
                let lTransform:CGAffineTransform = CGAffineTransformMakeTranslation(WeakS.offsetLX, WeakS.offsetLY)
                WeakS.originLeftHand.transform = lTransform
                
                let rTransform:CGAffineTransform =  CGAffineTransformMakeTranslation(-WeakS.offsetRX, WeakS.offsetRY)
                WeakS.originRightHand.transform = rTransform
            })
        }
        else
        {
            loginAnimationView.animateWithDuration(0.5, animations: { () -> Void in
                // 形变还原
                // CGAffineTransformIdentity:所有形变参数都是0
                WeakS.originLeftHand.transform = CGAffineTransformIdentity
                WeakS.originRightHand.transform = CGAffineTransformIdentity
                
                WeakS.leftArm.transform = CGAffineTransformMakeTranslation(-WeakS.offsetLX, -WeakS.offsetLY)
                WeakS.rightArm.transform = CGAffineTransformMakeTranslation(WeakS.offsetRX, -WeakS.offsetRY)
            })
        }
    }
}


