//
//  ViewController.swift
//  RunToMusic
//
//  Created by fox on 16/8/25.
//  Copyright © 2016年 fox. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let channel="1"
        let listURL:String
        listURL="https://douban.fm/j/mine/playlist?type=n&channel="+channel+"&from=mainsite"
        let url: NSURL! = NSURL(string: listURL)
        let request: NSURLRequest = NSURLRequest(URL: url)
        let session=NSURLSession.sharedSession()
        var tempurl:NSURL!
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            do {
                if error != nil{
                    print(error?.code)
                    print(error?.description)
                }else{
                    let jsonResult: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as!NSDictionary
                    let songInfo: NSArray = jsonResult["song"] as! NSArray
                    for info in songInfo{
                        var t:String!
                        t=info["url"] as! String
                        if t != ""{
                            print(t+"\n")
                            tempurl=NSURL(string: t)
                            print(t)
                        }
                    }
                    
                    
                    let configDefault = NSURLSessionConfiguration.defaultSessionConfiguration()
                    
                    configDefault.timeoutIntervalForRequest = 20
                    
                    let session1 = NSURLSession(configuration: configDefault)
                    
                    
                    
                    
                    let dataTask = session1.dataTaskWithURL(tempurl!, completionHandler: {(data2,response,error)->Void in
                        print(error)
                        
                        self.playsong(data2!)
                        
                        
                    })
                    dataTask.resume()

                    //print(songInfo)
                        //jsonResult.objectForKey("song")!
                    //let urlString: String=jsonResult.objectForKey("url") as! String
                    //let musicURL: NSURL!=NSURL(string: urlString)
                    //print(si)
                    //print(songInfo.objectForKey("url"))
                    //let str = NSString(data:data!, encoding: NSUTF8StringEncoding)
                    //print(str)
                }
            }catch {
                    print("json error\(error)")
            }
            
        })
        task.resume()
        

    }
    func playsong(musicdata:NSData){
        do{
            
            //try audioPlayer = AVAudioPlayer.init(contentsOfURL: url!)
            try audioPlayer = AVAudioPlayer(data: musicdata)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        }catch {
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

