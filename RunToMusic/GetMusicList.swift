//
//  GetMusicList.swift
//  RunToMusic
//
//  Created by fox on 16/8/25.
//  Copyright © 2016年 fox. All rights reserved.
//

import Foundation
import UIKit

class GetMusicList{
    var channel:Int
    init(channel:Int ){
        self.channel=channel
    }
    lazy var data = NSMutableData()
    func getPlaylist(cha:Int) -> Array<String> {
        let channel=String(cha)
        var playlist:Array<String>
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
                    print(str)
                }catch {
                    print("json error\(error)")
                }
                
            }
        })
        return [""]
    }
}