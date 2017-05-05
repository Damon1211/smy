//
//  ViewController.swift
//  smy
//
//  Created by kwj on 2017/3/30.
//  Copyright © 2017年 axlr. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController,WKNavigationDelegate,WKUIDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //loadUrlByFunc1();
 
        //loadUrlByFunc2();

        //loadUrlByFunc3();
        
        
        loadUrlByFunc4();
    }
    
    private var webView = WKWebView()
    private var progressView = UIProgressView()
    var open_url:String = "https://dev1.anxinlirong.com/smyunnew"
    
    
    func loadUrlByFunc4(){
        //1.设置访问资源
        let Url = URL.init(string: "http://res.anxinlirong.com/static/appurl.txt")
        
        let request = NSMutableURLRequest.init(url: Url!)
        
        request.timeoutInterval = 30
        
        //2.请求方式，跟OC一样的
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if (error != nil) {
                return
            }else {
                var responseStr = String(data: data!,encoding:String.Encoding.utf8);
                
                responseStr = responseStr?.replacingOccurrences(of: "\n", with: "");
                
                // Do any additional setup after loading the view, typically from a nib.
                // 1.设置访问资源 -
                //                let param = "{'deviceId':'"+CloudPushSDK.getDeviceId()+"'}";
                
                
                let deviceId:String
                
                if let tDeviceId = CloudPushSDK.getDeviceId() {
                    deviceId = tDeviceId
                }else{
                    deviceId = ""
                }
                
                let param = "{'deviceId':'"+deviceId+"'}"
                
                let encodeParam = param.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed);
                //
                self.open_url = (responseStr?.substring(to: (responseStr?.endIndex)!))! + "/?param="+encodeParam!
                
                self.loadWebUrl4()
            }
        }
        
        dataTask.resume()
    }
    
    func loadWebUrl4(){
        print("loadWebUrl4...")
        
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.height))
        webView.navigationDelegate = self
        webView.uiDelegate = self
        
        self.view.backgroundColor = UIColor.white
        
        // Do any additional setup after loading the view.
        let url = URL(string: open_url)
        let request = URLRequest(url: url!)
        webView.load(request)
        /**
         增加的属性：
         1.webView.estimatedProgress加载进度
         2.backForwardList 表示historyList
         3.WKWebViewConfiguration *configuration; 初始化webview的配置
         */
        self.view.addSubview(webView)
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
        progressView = UIProgressView(frame: CGRect(x: 0, y: 44-2, width: UIScreen.main.bounds.size.width, height: 2))
        //        progressView = UIProgressView(frame: CGRect(x: 10, y: 60, width: 100, height: 10))
        //        progressView = UIProgressView(frame: CGRectMake(10.0, 60.0, (self.view.bounds.width - 10.0 * 2), 10.0))
        
        progressView.trackTintColor = UIColor.white
        progressView.progressTintColor = UIColor.orange
        self.webView.addSubview(progressView)
        self.navigationController?.navigationBar.addSubview(progressView)
        
        let item = UIBarButtonItem(title: "<--", style: .plain, target: self, action: #selector(backItemPressed))
        self.navigationItem.leftBarButtonItem = item
    }
    
    func backItemPressed() {
        if webView.canGoBack {
            webView.goBack()
        }else{
            if let nav = self.navigationController {
                nav.popViewController(animated: true)
            }
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        progressView.isHidden = false
//        progressView.setProgress(Float(webView.estimatedProgress), animated: true)

        
        if (keyPath == "estimatedProgress") {
            progressView.isHidden = webView.estimatedProgress == 1
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
            print(webView.estimatedProgress)
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressView.setProgress(0.0, animated: false)
        self.navigationItem.title = webView.title
    }
    
    
    deinit {
        print("con is deinit")
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        progressView.reloadInputViews()
    }
    
    
    // 创建WKWebView
    let wkWebView = WKWebView(frame: UIScreen.main.bounds)

    func loadUrlByFunc3(){
        
        view.addSubview(wkWebView)
        
        //方案三******************begin
        //1.设置访问资源
        let Url = URL.init(string: "http://res.anxinlirong.com/static/appurl.txt")
        
        let request = NSMutableURLRequest.init(url: Url!)
        
        request.timeoutInterval = 30
        
        //2.请求方式，跟OC一样的
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if (error != nil) {
                return
            }else {
                var responseStr = String(data: data!,encoding:String.Encoding.utf8);
                
                responseStr = responseStr?.replacingOccurrences(of: "\n", with: "");
                
                // Do any additional setup after loading the view, typically from a nib.
                // 1.设置访问资源 -
                //                let param = "{'deviceId':'"+CloudPushSDK.getDeviceId()+"'}";
                
                
                let deviceId:String
                
                if let tDeviceId = CloudPushSDK.getDeviceId() {
                    deviceId = tDeviceId
                }else{
                    deviceId = ""
                }
                
                let param = "{'deviceId':'"+deviceId+"'}"
                
                let encodeParam = param.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed);
                //
                let fullUrl = (responseStr?.substring(to: (responseStr?.endIndex)!))! + "/?param="+encodeParam!
                //
                print("=============="+fullUrl)
                
                // 设置访问的UR
                let url = NSURL(string: fullUrl)
                // 根据URL创建请求
                let request = URLRequest(url: url! as URL);
                // WKWebView加载请求
                self.wkWebView.load(request)
                // 将WKWebView添加到视图
                self.view.addSubview(self.wkWebView)
                
            }
        }
        
        dataTask.resume()
        //方案三******************end
    }
    
    
    
    func loadUrlByFunc2(){
        //方案二******************begin
        //1.设置访问资源
        let Url = URL.init(string: "http://res.anxinlirong.com/static/appurl.txt")
        
        let request = NSMutableURLRequest.init(url: Url!)
        
        request.timeoutInterval = 30
        
        //2.请求方式，跟OC一样的
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if (error != nil) {
                return
            }else {
                var responseStr = String(data: data!,encoding:String.Encoding.utf8);
                
                responseStr = responseStr?.replacingOccurrences(of: "\n", with: "");
                
                // Do any additional setup after loading the view, typically from a nib.
                // 1.设置访问资源 -
                //                let param = "{'deviceId':'"+CloudPushSDK.getDeviceId()+"'}";
                
                
                let deviceId:String
                
                if let tDeviceId = CloudPushSDK.getDeviceId() {
                    deviceId = tDeviceId
                }else{
                    deviceId = ""
                }
                
                let param = "{'deviceId':'"+deviceId+"'}"
                
                let encodeParam = param.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed);
                //
                let fullUrl = (responseStr?.substring(to: (responseStr?.endIndex)!))! + "/?param="+encodeParam!
                //
                print("=============="+fullUrl)
                
//                var url = URL(string: fullUrl);
                
                // 2.建立网络请求
//                let request = URLRequest(url: url!);
                // 3.加载网络请求
//                self.weview.load(request);
                
            }
        }
        
        dataTask.resume()
        //方案二******************end
    }
    
    func loadUrlByFunc1() {
        //方案二******************begin
        
        // Do any additional setup after loading the view, typically from a nib.
        // 1.设置访问资源 -
        var deviceId:String?
        
        if let tDeviceId = CloudPushSDK.getDeviceId() {
            deviceId = tDeviceId
        }else{
            deviceId = ""
        }
        
        
        let param:String = "{'deviceId':'\(String(describing: deviceId))'}"
        
        let encodeParam = param.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed);
        
        let url = URL(string: "http://dev1.anxinlirong.com/smyunnew/ims/login/?param="+encodeParam!);
        
        
        print(url ?? "no url")
        // 2.建立网络请求
//        let request = URLRequest(url: url!);
        // 3.加载网络请求
//        self.wkWebView.loadRequest(request);
        
        //方案二******************end
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    
    

}

