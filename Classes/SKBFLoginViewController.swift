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
    
    // TODO: Change style.
    var blurEffectStyle: UIBlurEffectStyle = .Light
    
    // TODO: Change images array.
    var backgroundArray = [UIImage(named: "img1.jpg"),UIImage(named:"img2.jpg"), UIImage(named: "img3.jpg"), UIImage(named: "img4.jpg"), UIImage(named: "img5.jpg")]
    
    // MARK: Outlets for UI Elements and buttons bottom constraints
    // TODO: Link these IBOutlets to xib.
    @IBOutlet weak var leftBtnBottomConstraint:  NSLayoutConstraint!
    @IBOutlet weak var rightBtnBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageView:                UIImageView!
    @IBOutlet weak var usernameField:            UITextField!
    @IBOutlet weak var passwordField:            UITextField!
    @IBOutlet weak var confirmField:             UITextField!
    @IBOutlet weak var leftBtn:                  UIButton!
    @IBOutlet weak var rightBtn:                 UIButton!
    
    // MARK: ViewController mode
    enum ViewContollerMode {
        case MainPage
        case Login
        case Signup
    }
    var currentMode: ViewContollerMode
    
    // MARK: Global Variables for Changing Image Functionality.
    private var idx: Int = 0
    
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
        
        // Default mode.
        currentMode = .MainPage
        
        // Default buttons settings.
        buttonAppearanceSetup(leftBtn)
        buttonAppearanceSetup(rightBtn)
        leftBtn.setTitle("Login", forState: .Normal)
        rightBtn.setTitle("Sign up", forState: .Normal)
        
        // Gradient animation of controls.
        usernameField.alpha = 0;
        passwordField.alpha = 0;
        confirmField.alpha  = 0;
        leftBtn.alpha       = 0;
        rightBtn.alpha      = 0;
        
        UIView.animateWithDuration(0.7, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.usernameField.alpha = 1.0
            self.passwordField.alpha = 1.0
            self.confirmField.alpha  = 1.0
            self.leftBtn.alpha       = 1.0
            self.rightBtn.alpha      = 1.0
            }, completion: nil)
        
        usernameField.hidden = true
        passwordField.hidden = true
        confirmField.hidden  = true
        
        // Notifiying for Changes in the textFields
        usernameField.addTarget(self, action: #selector(SKBFLoginViewController.textFieldDidEndEditing), forControlEvents: UIControlEvents.EditingDidEnd)
        passwordField.addTarget(self, action: #selector(SKBFLoginViewController.textFieldDidEndEditing), forControlEvents: UIControlEvents.EditingDidEnd)
        confirmField.addTarget(self, action: #selector(SKBFLoginViewController.textFieldDidEndEditing), forControlEvents: UIControlEvents.EditingDidEnd)
        
        // Visual Effect View for background
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: blurEffectStyle)) as UIVisualEffectView
        visualEffectView.frame = UIScreen.mainScreen().bounds
        visualEffectView.alpha = 0.6
        imageView.image = backgroundArray[0]
        imageView.addSubview(visualEffectView)
        
        NSTimer.scheduledTimerWithTimeInterval(6, target: self, selector: #selector(SKBFLoginViewController.changeImage), userInfo: nil, repeats: true)
    }
    
    // MARK: Mode switch
    @IBAction func leftBtnPressed(sender: UIButton) {
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
    
    @IBAction func rightBtnPressed(sender: UIButton) {
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
        
        self.leftBtnBottomConstraint.constant -= yOffset
        self.rightBtnBottomConstraint.constant -= yOffset
    }
    
    // Utils
    private func buttonAppearanceSetup(button: UIButton) {
        button.tintColor = UIColor.whiteColor()
        button.setTitleColor(UIColor.whiteColor(), forState: .Disabled)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.backgroundColor = UIColor.clearColor()
        button.layer.cornerRadius = 8.0
        button.clipsToBounds = true
        button.layer.borderWidth = 1;
        button.layer.borderColor = UIColor.whiteColor().CGColor
    }
    
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