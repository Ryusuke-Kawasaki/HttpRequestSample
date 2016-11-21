//
//  ViewController.swift
//  HttpRequestSample
//
//  Created by 川崎 隆介 on 2015/12/15.
//  Copyright (c) 2015年 川崎 隆介. All rights reserved.
//

import UIKit

class ViewController: UIViewController,JSONParserDelegate {
    //通知メソッドの実装
    func didParse(_ person: Person) {
        //コンソール出力
        print(person.name)
        print(person.age)
    }

    
    
    
    func responseJSON(_ data:Data?,res:URLResponse?,error:Error?){
        if let jsonData = data {
            do {
                //NSDataをJSON形式に変換。JSON形式のデータはNSDictionaryとして扱う
                let json = try JSONSerialization.jsonObject(with:jsonData) as! NSDictionary
                //キーを指定してJSONから値を取得
                let name = json["name"] as! String
                let age = json["age"] as! Int
                //コンソール出力
                print(name)
                print(age)
            } catch  {
                
            }
        }
    }
    
    let networkSercive = NetworkService()

    @IBAction func pushJSONParse(_ sender: AnyObject) {
        networkSercive.delegate = self
        networkSercive.requestJSONSample()
        
        // 通信先のURLを生成.
        //let url = URL(string:"http://codable.co.jp/training/swift/jsonsample.php")!
        // リクエストを生成.
        //let request  = URLRequest(url: url)
        //非同期要求
        //NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:responseJSON)
        
        //let session = URLSession.shared
        //let task = session.dataTask(with:request, completionHandler:self.responseJSON)
        //task.resume()
        
    }


    //サーバーからの応答を受け取るメソッド
    func response(_ data:Data?,res:URLResponse?,error:Error?){
        // 応答データを文字列に変換.
        let dataStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!
        print(dataStr)
    }
    
    @IBAction func pushSendAsyncRequest(_ sender: AnyObject) {
        // 通信先のURLを生成.
        let url = URL(string:"http://codable.co.jp/training/swift/hello.php?name=sample")!
        // リクエストを生成.
        let request  = URLRequest(url: url)
        //非同期要求
        //NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main, completionHandler:self.response as! (URLResponse?, Data?, Error?) -> Void)
        let session = URLSession.shared
        let task = session.dataTask(with:request, completionHandler:self.response)
        task.resume()
    }
    
    @IBAction func pushSendRequest(_ sender: AnyObject) {
        // 通信先のURLを生成.
        let url = URL(string:"http://codable.co.jp/training/swift/hello.php")!
        // リクエストを生成.
        let request  = URLRequest(url: url)
        // 送信処理を始める.
        do {
            let res = try NSURLConnection.sendSynchronousRequest(request, returning: nil)
            // 応答データを文字列に変換.
            let resStr = NSString(data:res, encoding: String.Encoding.utf8.rawValue)
            //コンソール出力
            print(resStr)
        } catch  {
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

