//
//  NetworkService.swift
//  HttpRequestSample
//
//  Created by 川崎 隆介 on 2015/12/16.
//  Copyright (c) 2015年 川崎 隆介. All rights reserved.
//

import UIKit

class NetworkService: NSObject {
    weak var delegate:JSONParserDelegate?
    
    private func responseJSON(data:Data?,res:URLResponse?,error:Error?){
        if let jsonData = data {
            do {
                //NSDataをJSON形式に変換。JSON形式のデータはNSDictionaryとして扱う
                let json = try JSONSerialization.jsonObject(with:jsonData) as! NSDictionary
                //Personオブジェクト生成
                let person = Person()
                //キーを指定してJSONから値を取得
                person.name = json["name"] as! String
                person.age = json["age"] as! Int
                //通知処理
                if let d = delegate {
                    d.didParse(person: person)
                }
            } catch  {
                
            }
            
        }
    }
    
    func requestJSONSample(){
        // 通信先のURLを生成.
        let url = URL(string:"http://codable.co.jp/training/swift/jsonsample.php")!
        // リクエストを生成.
        let request  = URLRequest(url: url)
        //非同期要求
        //NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main, completionHandler:responseJSON as! (URLResponse?, Data?, Error?) -> Void)
        let session = URLSession.shared
        let task = session.dataTask(with:request, completionHandler:self.responseJSON)
        task.resume()

    }
}

