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
        
        //1.设置访问资源
//        let urlData = URL(string: "http://res.anxinlirong.com/static/appurl.txt");
//        
//        print(urlData?.absoluteString ?? "url is none")
//        //2.建立网络请求
//        let requestUrl = URLRequest(url: urlData!);
//        
//        //3.发送请求
//        NSURLConnection.sendAsynchronousRequest(requestUrl, queue:OperationQueue()) { (res, data, error)in
//            //服务器返回：请求方式 = GET，返回数据格式 = JSON，用户名 = 123，密码 = 1233
//            let urlPrefix = NSString(data: data!, encoding:String.Encoding.utf8.rawValue)! as String;
//        
//            // Do any additional setup after loading the view, typically from a nib.
//            // 1.设置访问资源 -
//            let param = "{'deviceId':'"+CloudPushSDK.getDeviceId()+"'}";
//            
//            let encodeParam = param.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed);
//            
//            let url = URL(string: urlPrefix + "/?param="+encodeParam!);
//            
//            //print("=============="+(url?.absoluteString)!)
//            
//            //print(url?.absoluteString ?? "url is none")
//            // 2.建立网络请求
//            let request = URLRequest(url: url!);
//            // 3.加载网络请求
//            self.webView.loadRequest(request);
//        }
//        
        
        //方案
        let Url = URL.init(string: "http://res.anxinlirong.com/static/appurl.txt")
        
        let request = NSMutableURLRequest.init(url: Url!)
        
        request.timeoutInterval = 30
        //请求方式，跟OC一样的
        request.httpMethod = "GET"
        request.httpBody = "".data(using: String.Encoding.utf8)
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if (error != nil) {
                return
            }else {
                
                var responseStr = String(data: data!,encoding:String.Encoding.utf8);
                
                
                
                
                responseStr = responseStr?.replacingOccurrences(of: "\n", with: "");
                print(responseStr)
                // Do any additional setup after loading the view, typically from a nib.
                // 1.设置访问资源 -
//                let param = "{'deviceId':'"+CloudPushSDK.getDeviceId()+"'}";
                
                
                let deviceId = CloudPushSDK.getDeviceId();
                
                let param = "{'deviceId':'"+deviceId!+"'}"
                
                
                let encodeParam = param.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed);
//
                let fullUrl = (responseStr?.substring(to: (responseStr?.endIndex)!))! + "/?param="+encodeParam!
//
                print("=============="+fullUrl)
                
                let url = URL(string: fullUrl);
                
                // 2.建立网络请求
                let request = URLRequest(url: url!);
                // 3.加载网络请求
                self.webView.loadRequest(request);
            }
        }
        
        dataTask.resume()
        
        
        
        
        //方案
        
        
//        // Do any additional setup after loading the view, typically from a nib.
//        // 1.设置访问资源 -
//        let param = "{'deviceId':'"+CloudPushSDK.getDeviceId()+"'}";
//        
//        let encodeParam = param.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed);
//        
//        let url = URL(string: "http://47.93.85.102:8081/smyunnew/ims/login/?param="+encodeParam!);
//        
//        print("=============="+(url?.absoluteString)!)
//        
//        print(url?.absoluteString ?? "url is none")
//        // 2.建立网络请求
//        let request = URLRequest(url: url!);
//        // 3.加载网络请求
//        self.webView.loadRequest(request);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    
    

}

