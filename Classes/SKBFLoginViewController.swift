//
//  SKBFLoginViewController.swift
//  SKBFLoginViewControllerDemo
//
//  Created by 孙恺 on 16/3/26.
//  http://www.talisk.cn/
//  Copyright © 2016年 sunkai. All rights reserved.
//

import UIKit

class SKBFLoginViewController: UIViewController {
    
    // MARK: Singleton ViewController
    static let sharedInstance = SKBFLoginViewController()
    
    // TODO: Implement them.
    func login() {
        print("Login button pressed")
    }
    
    func signup() {
        print("Sign up button pressed.")
    }
    
    func textFieldDidEndEditing() {
        print("Textfield format validation.")
    }
    
    // MARK: Defaults style
    var blurEffectStyle: UIBlurEffectStyle = .Light
    
    var backgroundArray = [UIImage(named: "img1.jpg"),UIImage(named:"img2.jpg"), UIImage(named: "img3.jpg"), UIImage(named: "img4.jpg"), UIImage(named: "img5.jpg")]
    
    // MARK: Outlets for UI Elements and buttons bottom constraints
    var imageView:                UIImageView!
    var usernameField:            UITextField!
    var passwordField:            UITextField!
    var confirmField:             UITextField!
    var leftBtn:                  UIButton!
    var rightBtn:                 UIButton!
    
    // MARK: Image changing and mode switch.
    private var idx: Int = 0
    
    enum ViewContollerMode {
        case MainPage
        case Login
        case Signup
    }
    var currentMode: ViewContollerMode = .MainPage
    
    // MARK: Singleton private init methods
    private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        self.currentMode = .MainPage
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Controller LifeCycle
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SKBFLoginViewController.keyboardWillChangeFrame(_:)), name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controlSetup()
        
        NSTimer.scheduledTimerWithTimeInterval(6, target: self, selector: #selector(SKBFLoginViewController.changeImage), userInfo: nil, repeats: true)
    }
    
    // MARK: UI Setup
    
    // Control setup
    
    private func controlSetup() {
        
        // Buttons
        
        leftBtn = getButton()
        rightBtn = getButton()
        
        leftBtn.addTarget(self, action: #selector(SKBFLoginViewController.leftBtnPressed(_:)), forControlEvents: .TouchUpInside)
        rightBtn.addTarget(self, action: #selector(SKBFLoginViewController.rightBtnPressed(_:)), forControlEvents: .TouchUpInside)
        
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        
        imageView = UIImageView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        imageView.contentMode = .ScaleAspectFill
        
        leftBtn.frame = CGRectMake(0, 0, screenWidth*0.4, 28)
        rightBtn.frame = CGRectMake(0, 0, screenWidth*0.4, 28)
        leftBtn.center = CGPointMake(screenWidth*0.25, screenHeight-42)
        rightBtn.center = CGPointMake(screenWidth*0.75, screenHeight-42)
        
        // Fields
        
        usernameField = getField()
        passwordField = getField()
        confirmField = getField()
        
        usernameField.placeholder = "Username"
        passwordField.placeholder = "Password"
        confirmField.placeholder = "Confrim"
        
        usernameField.frame = CGRectMake(0, 0, 0.85*screenWidth, 34)
        passwordField.frame = CGRectMake(0, 0, 0.85*screenWidth, 34)
        confirmField.frame = CGRectMake(0, 0, 0.85*screenWidth, 34)
        usernameField.center = CGPointMake(screenWidth/2, 44)
        passwordField.center = CGPointMake(screenWidth/2, 88)
        confirmField.center = CGPointMake(screenWidth/2, 132)
        
        self.view.addSubview(imageView)
        self.view.addSubview(leftBtn)
        self.view.addSubview(rightBtn)
        self.view.addSubview(usernameField)
        self.view.addSubview(passwordField)
        self.view.addSubview(confirmField)
        
        leftBtn.setTitle("Login", forState: .Normal)
        rightBtn.setTitle("Sign up", forState: .Normal)
        
        usernameField.hidden = true
        passwordField.hidden = true
        confirmField.hidden  = true
        
        // Visual Effect View for background
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: blurEffectStyle)) as UIVisualEffectView
        visualEffectView.frame = UIScreen.mainScreen().bounds
        visualEffectView.alpha = 0.6
        imageView.image = backgroundArray[0]
        imageView.addSubview(visualEffectView)
        
        // Notifiying for Changes in the textFields
        let fieldEndEditingSelector = #selector(SKBFLoginViewController.textFieldDidEndEditing)
        
        usernameField.addTarget(self, action: fieldEndEditingSelector, forControlEvents: UIControlEvents.EditingDidEnd)
        passwordField.addTarget(self, action: fieldEndEditingSelector, forControlEvents: UIControlEvents.EditingDidEnd)
        confirmField.addTarget(self, action: fieldEndEditingSelector, forControlEvents: UIControlEvents.EditingDidEnd)
    }
    
    
    // Factory method.
    private func getField() -> UITextField {
        let field = UITextField()
        field.borderStyle = .RoundedRect
        field.layer.cornerRadius = 8.0
        field.layer.borderWidth = 1.6;
        field.layer.borderColor = UIColor.whiteColor().CGColor
        return field
    }
    
    // Factory method.
    private func getButton() -> UIButton {
        let button = UIButton(type: .Custom)
        button.tintColor = UIColor.whiteColor()
        button.setTitleColor(UIColor.whiteColor(), forState: .Disabled)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.backgroundColor = UIColor.clearColor()
        button.layer.cornerRadius = 8.0
        button.clipsToBounds = true
        button.layer.borderWidth = 1;
        button.layer.borderColor = UIColor.whiteColor().CGColor
        return button
    }
    
    // MARK: Mode switch
    func leftBtnPressed(sender: UIButton) {
        leftBtn.enabled = false
        
        switch currentMode {
        case .MainPage:
            toggleFieldWithMode(.Login)
            
            buttonTextChange(leftBtn, newText: "Return")
            buttonTextChange(rightBtn, newText: "Login")
            
            currentMode = .Login
            break
            
        case .Login, .Signup:
            toggleFieldWithMode(.MainPage)
            buttonTextChange(leftBtn, newText: "Login")
            buttonTextChange(rightBtn, newText: "Sign up")
            allTextFieldResignFirstResponder()
            currentMode = .MainPage
            break
        }
    }
    
    func rightBtnPressed(sender: UIButton) {
        rightBtn.enabled = false
        
        switch currentMode {
        case .MainPage:
            
            toggleFieldWithMode(.Signup)
            
            buttonTextChange(leftBtn, newText: "Return")
            buttonTextChange(rightBtn, newText: "Sign up")
            
            currentMode = .Signup
            break
            
        case .Login:
            
            login()
            rightBtn.enabled = true
            
            break
            
        case .Signup:
            
            signup()
            rightBtn.enabled = true
            
            break
            
        }
    }
    
    private func toggleFieldWithMode(mode: ViewContollerMode) {
        
        let duration = 0.5
        
        switch mode {
        case .Login:
            usernameField.alpha = 0
            passwordField.alpha = 0
            confirmField.alpha = 0
            
            UIView.animateWithDuration(duration, animations: {
                self.usernameField.hidden = false
                self.passwordField.hidden = false
                self.confirmField.hidden = true
                self.usernameField.alpha = 1
                self.passwordField.alpha = 1
                self.confirmField.alpha = 1
                self.imageView.subviews[0].alpha = 1
                }, completion: { (true) in
                    
                    self.rightBtn.enabled = true
                    self.leftBtn.enabled = true
            })
            
        case .Signup:
            usernameField.alpha = 0
            passwordField.alpha = 0
            confirmField.alpha = 0
            
            UIView.animateWithDuration(duration, animations: {
                self.usernameField.hidden = false
                self.passwordField.hidden = false
                self.confirmField.hidden = false
                self.usernameField.alpha = 1
                self.passwordField.alpha = 1
                self.confirmField.alpha = 1
                self.imageView.subviews[0].alpha = 1
                }, completion: { (true) in
                    
                    self.rightBtn.enabled = true
                    self.leftBtn.enabled = true
            })
            
        default:
            usernameField.alpha = 1
            passwordField.alpha = 1
            confirmField.alpha = 1
            
            UIView.animateWithDuration(duration, animations: {
                self.usernameField.alpha = 0
                self.passwordField.alpha = 0
                self.confirmField.alpha = 0
                self.imageView.subviews[0].alpha = 0.6
                }, completion: { (true) in
                    
                    self.usernameField.hidden = true
                    self.passwordField.hidden = true
                    self.confirmField.hidden = true
                    self.rightBtn.enabled = true
                    self.leftBtn.enabled = true
            })
        }
    }
    
    private func buttonTextChange(button: UIButton, newText: NSString) {
        button.setTitle(newText as String, forState: .Normal)
    }
    
    //MARK: Keyboard notification callback.
    func keyboardWillChangeFrame(notification: NSNotification) {
        let beginKeyboardRect = notification.userInfo![UIKeyboardFrameBeginUserInfoKey]?.CGRectValue()
        let endKeyboardRect = notification.userInfo![UIKeyboardFrameEndUserInfoKey]?.CGRectValue()
        
        let yOffset = endKeyboardRect!.origin.y - beginKeyboardRect!.origin.y
        
        UIView.animateWithDuration(1, delay: 0, options: UIViewAnimationOptions.BeginFromCurrentState, animations: { 
            var leftBtnFrame = self.leftBtn.frame
            var rightBtnFrame = self.rightBtn.frame
            
            leftBtnFrame.origin.y += yOffset
            rightBtnFrame.origin.y += yOffset
            
            self.leftBtn.frame = leftBtnFrame
            self.rightBtn.frame = rightBtnFrame
            }, completion: nil)
    }
    
    // MARK: Utils
    
    func changeImage(){
        if idx == backgroundArray.count-1 {
            idx = 0
        }
        else {
            idx += 1
        }
        let toImage = backgroundArray[idx];
        UIView.transitionWithView(self.imageView, duration: 1, options: [.BeginFromCurrentState, .TransitionCrossDissolve], animations: {self.imageView.image = toImage}, completion: nil)
    }
    
    private func allTextFieldResignFirstResponder() {
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        confirmField.resignFirstResponder()
    }
    
}