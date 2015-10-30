//
//  loginAnimationViewController.swift
//  
//
//  Created by Kiss-shot Acerola-orion Heart-under-blade on 15/1/14.
//  Copyright (c) 2015年 PX. All rights reserved.
//

import UIKit

private let account:String = "asd"
private let password:String = "123"

class LoginVC: UIViewController,UITextFieldDelegate,PXAnimatedImagesViewDelegate{
    
    @IBOutlet weak var UserTextField: UITextField!
    @IBOutlet weak var PassWordTextField: UITextField!
    @IBOutlet weak var LoginBtn: UIButton!
    @IBOutlet weak var PXLoginAnimationView: loginAnimationView!
    @IBOutlet weak var animatedImagesView: PXAnimatedImagesView!
    
    lazy var imageArray:Array<UIImage?> = [UIImage(named: "loginAnimationVC.bundle/changan0.jpg"),UIImage(named: "loginAnimationVC.bundle/changan1.jpg.jpg")]
    
    override func viewDidLoad()
    {
        animatedImagesView.delegate = self
        
        textFieldChange()
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: Selector("keyboardWillChange:"),
            name: UIKeyboardWillChangeFrameNotification,
            object: self.view.window)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        animatedImagesView.startAnimating()
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
        animatedImagesView.stopAnimating()
    }
    /*---------------------------------------Storyboard 上 按 键 相 关------------------------------------*/
    @IBAction func clickTextField(sender: UITextField) {
        switch sender
        {
        case UserTextField:
            PXLoginAnimationView.setAnimation(false)
            
        case PassWordTextField:
            PXLoginAnimationView.setAnimation(true)
            self.PassWordTextField.secureTextEntry = true
        default:""
        }
        !PassWordTextField.text!.isEmpty && !UserTextField.text!.isEmpty ? LoginBtn.enabled = true:(LoginBtn.enabled = false)
    }
    
    @IBAction func clickLoginBtn(sender: UIButton) {
        PassWordTextField.text == password && UserTextField.text == account ? self.start(): passwordWrongAlert()
    }
    func start()
    {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        UIApplication.sharedApplication().keyWindow?.rootViewController = vc
        let animation = CATransition()
        animation.type = "rippleEffect"
        animation.duration = 1
        UIApplication.sharedApplication().keyWindow!.layer.addAnimation(animation, forKey: nil)
    }
    func textFieldChange()
    {
        UserTextField.addTarget(self, action: Selector("textFieldWillChange:"), forControlEvents: UIControlEvents.EditingChanged)
    }
    /*------------------------------------------ 提 示 框 ---------------------------------------------*/
    func passwordWrongAlert()
    {
        if #available(iOS 8.0, *) {
            let alert1:UIAlertController = UIAlertController(title: "用户名或密码错误", message: "请重新核对用户名和密码", preferredStyle: .Alert)
            
            let action1:UIAlertAction = UIAlertAction(title: "确定", style: .Destructive)
                {(UIAlertAction) -> Void in}
            
            let action2:UIAlertAction = UIAlertAction(title: "取消", style: .Cancel)
                {(UIAlertAction) -> Void in}
            
            alert1.addAction(action1)
            alert1.addAction(action2)
            
            self.presentViewController(alert1, animated: true, completion: nil)
        } else {
            let alert = UIAlertView(title: "用户名或密码错误", message: "请重新核对用户名和密码", delegate: self, cancelButtonTitle: "确定")
            alert.show()
        }
        
    }
    func animatedImagesNumberOfImages(animatedImagesView: PXAnimatedImagesView) -> Int {
        return  2
    }
    func animatedImagesViewAndImageAtIndex(animatedImagesView: PXAnimatedImagesView, index: Int) -> UIImage! {
        return imageArray[index]!
    }
    /*------------------------------------------ 键 盘 动 画 ---------------------------------------------*/
    func keyboardWillChange(noti:NSNotification)
    {
        if let userInfo = noti.userInfo
        {
            self.view.frame = CGRectMake(0, -50, self.view.frame.size.width, self.view.frame.size.height)
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey]?.doubleValue
    
            UIView.animateWithDuration(duration!, animations: { () -> Void in
                self.view.layoutIfNeeded()
            })
        }
    }
    func textFieldWillChange(textField:UITextField)
    {
        textField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0 ? textField.font = UIFont(name: "Heiti SC", size: 18) : (textField.font = UIFont(name: "Heiti SC", size: 25))
    }
}
