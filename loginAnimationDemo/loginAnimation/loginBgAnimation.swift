//
//  LoginBgAnimation.swift
//  
//
//  Created by Kiss-shot Acerola-orion Heart-under-blade on 15/1/15.
//  Copyright © 2015年 PX. All rights reserved.
//

import UIKit

protocol PXAnimatedImagesViewDelegate
{
    func animatedImagesNumberOfImages(animatedImagesView:PXAnimatedImagesView)->Int
    func animatedImagesViewAndImageAtIndex(animatedImagesView:PXAnimatedImagesView,index:Int)->UIImage!
}

private let kJSAnimatedImagesViewDefaultTimePerImage = 20.0
private let noImageDisplayingIndex:Int = -1
private let imageSwappingAnimationDuration = 2.0
private let imageViewsBorderOffset:CGFloat = 150.0

class PXAnimatedImagesView: UIView
{
    var delegate:PXAnimatedImagesViewDelegate?
    {
        didSet
        {
            totalImages = (delegate?.animatedImagesNumberOfImages(self))!
        }
    }
    var timePerImage:NSTimeInterval
        {
            get
            {
                return kJSAnimatedImagesViewDefaultTimePerImage
            }
        }
    var imageSwappingTimer:NSTimer
        {
        get
        {
            return NSTimer.scheduledTimerWithTimeInterval(self.timePerImage, target: self, selector: Selector("bringNextImage"), userInfo: nil, repeats: true)
        }
    }
    
    lazy var animating:Bool = false
    lazy var imageViews:Array<UIImageView> = []
    lazy var totalImages:Int = 0
    lazy var currentlyDisplayingImageViewIndex:Int = 0
    lazy var currentlyDisplayingImageIndex:Int = 0
    /*------------------------------------------↑↑↑↑↑属 性 相 关↑↑↑↑↑----------------------------------------------*/
    /*------------------------------------------↓↓↓↓↓↓ 初 始 化 ↓↓↓↓↓----------------------------------------------*/
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    func setup()
    {
        for _ in 0...1
        {
            let imageView = UIImageView(frame:CGRectMake(-imageViewsBorderOffset * 1.5, 0, self.bounds.size.width + (imageViewsBorderOffset * 2), self.bounds.size.height + (imageViewsBorderOffset * 2)))

            imageView.autoresizingMask = UIViewAutoresizing.FlexibleWidth
            imageView.autoresizingMask.insert(UIViewAutoresizing.FlexibleHeight)
            imageView.contentMode = .TopRight
            imageView.clipsToBounds = false
            
            self.addSubview(imageView)
            imageViews.append(imageView)
        }
        currentlyDisplayingImageIndex = noImageDisplayingIndex
    }
    /*------------------------------------------↓↓↓↓↓↓ 动 画 方 法 ↓↓↓↓↓----------------------------------------------*/
    /// 换页
    func bringNextImage()
    {
        let imageViewToHide = imageViews[currentlyDisplayingImageViewIndex]
        currentlyDisplayingImageViewIndex = currentlyDisplayingImageViewIndex == 0 ? 1 : 0
        let imageViewToShow = imageViews[currentlyDisplayingImageViewIndex]
        var nextImageToShowIndex = currentlyDisplayingImageIndex
        
        repeat
        {
           nextImageToShowIndex = randomIntBetweenMinNumberAndMaxNumber(0, max:totalImages - 1)
        }
        while (nextImageToShowIndex == currentlyDisplayingImageIndex)
    
        currentlyDisplayingImageIndex = nextImageToShowIndex
        imageViewToShow.image = delegate!.animatedImagesViewAndImageAtIndex(self, index: nextImageToShowIndex)
        
        let kMovementAndTransitionTimeOffset = 0.1
        
        UIView.animateWithDuration(
            timePerImage + imageSwappingAnimationDuration + kMovementAndTransitionTimeOffset,
            delay: 0.0,
            options: UIViewAnimationOptions.BeginFromCurrentState,
            animations: { () -> Void in
                let randomTranslationValueX:CGFloat = imageViewsBorderOffset * 3.5 - CGFloat(self.randomIntBetweenMinNumberAndMaxNumber(0, max: Int(imageViewsBorderOffset)))
                let translationTransform = CGAffineTransformMakeTranslation(randomTranslationValueX, 0)
                let randomScaleTransformValue = self.randomIntBetweenMinNumberAndMaxNumber(115, max: 120) / 100
                let scaleTransform = CGAffineTransformMakeScale(CGFloat(randomScaleTransformValue) , CGFloat(randomScaleTransformValue))
                imageViewToShow.transform = CGAffineTransformConcat(scaleTransform, translationTransform)
                
            }) { (_) -> Void in
        }        
        UIView.animateWithDuration(
            2.0,
            delay: 0.1,
            options: .BeginFromCurrentState,
            animations: { () -> Void in
                imageViewToShow.alpha = 1.0
                imageViewToHide.alpha = 0.0
            })
            { (finished:Bool) -> Void in
                if finished
                {
                    imageViewToHide.transform = CGAffineTransformIdentity
                }
            }
    }
    /// 刷新
    func reloadData()
    {
        totalImages = self.delegate!.animatedImagesNumberOfImages(self)
        imageSwappingTimer.fire()
    }
    /// 开始
    func startAnimating()
    {
        if animating == false
        {
            animating = true
            imageSwappingTimer.fire()
        }
    }
    /// 停止
    func stopAnimating()
    {
        if animating
        {
            imageSwappingTimer.invalidate()

            UIView.animateWithDuration(imageSwappingAnimationDuration, delay: 0.0, options: .BeginFromCurrentState, animations:
                { () -> Void in
                    for imageView in self.imageViews
                    {
                        imageView.alpha = 0
                    }
                }, completion: { (finished:Bool) -> Void in
                    self.currentlyDisplayingImageIndex = noImageDisplayingIndex
                    self.animating = false
            })
        }
    }
    /// 随机数
    func randomIntBetweenMinNumberAndMaxNumber(min:Int,max:Int)->Int
    {
        return  min > max ? randomIntBetweenMinNumberAndMaxNumber(max, max: min) : Int((arc4random() % UInt32((max - min + 1))) + UInt32(min))
    }
}
