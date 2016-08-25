//
//  ViewController.swift
//  RunToMusic
//
//  Created by fox on 16/8/25.
//  Copyright © 2016年 fox. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let channel="1"
        let listURL:String
        listURL="https://douban.fm/j/mine/playlist?type=n&channel="+channel+"&from=mainsite"
        let url: NSURL! = NSURL(string: listURL)
        let request: NSURLRequest = NSURLRequest(URL: url)
        let session=NSURLSession.sharedSession()
        let data=session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            if error != nil{
                print(error?.code)
                print(error?.description)
            }else{
                do{
                    let jsonResult: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    print(jsonResult)
                    let str = NSString(data:data!, encoding: NSUTF8StringEncoding)
                    print("aaaaaaa")
                    print(str)
                }catch {
                    print("json error\(error)")
                }
                
            }
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

