//
//  SKBFLoginViewController.swift
//  SKBFLoginViewControllerDemo
//
//  Created by 孙恺 on 16/3/26.
//  http://www.talisk.cn/
//  Copyright © 2016年 sunkai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func presentVC(sender: AnyObject) {
        
        let loginVC = SKBFLoginViewController.sharedInstance // Singleton
        loginVC.blurEffectStyle = .Light // Default style is light
        presentViewController(SKBFLoginViewController.sharedInstance, animated: true, completion: nil)
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

