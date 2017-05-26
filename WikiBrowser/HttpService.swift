//
//  HttpService.swift
//  WikiBrowser
//
//  Created by u0835059 on 4/19/17.
//  Copyright © 2017 Samuel Davidson. All rights reserved.
//

import UIKit

class HttpService {
    
    //TODO: Consider alternative languages
    private let urlPrefix = "https://en.m.wikipedia.org/wiki/"
    
    init(){
        
        let url = URL(string: "https://en.m.wikipedia.org/wiki/Main_Page")
        
        let urlRequest = URLRequest(url: url!)
        
        
    }
    public func getWikiPage(name:String){
        let url = URL(string: urlPrefix + name)
        
        let urlRequest = URLRequest(url: url!)
        
        //let config = URLSessionConfiguration.default
        
        //let session = URLSession(configuration: config)
        
        //let task = session.dataTask(with: urlRequest, completionHandler: requestHandler)
        
        //task.resume()
        
    }
    
    public func requestHandler(data : Data?, response: URLResponse?, error: Error? ) {
        print("Returned")
        if let d = data, let r = response {
            print(r.expectedContentLength)
            //webView.load(d, mimeType: "text/html", textEncodingName: "TEST-8", baseURL: URL(string: "test")!)
            //print(String(data: d, encoding: .utf8)!)
        }
    }
    
    
}
