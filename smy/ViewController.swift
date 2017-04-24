//
//  ViewController.swift
//  smy
//
//  Created by kwj on 2017/3/30.
//  Copyright © 2017年 axlr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // 1.设置访问资源 -
        
        
        var deviceId:String? = CloudPushSDK.getDeviceId();
        
        if let tDeviceId = deviceId {
            print("==============="+CloudPushSDK.getDeviceId());
        }
    
        let url = URL(string: "http://47.93.85.102:8081/smyunnew/ims/login/");
        // 2.建立网络请求
        let request = URLRequest(url: url!);
        // 3.加载网络请求
        webView.loadRequest(request);
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    
    

}

