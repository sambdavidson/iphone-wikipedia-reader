//
//  HttpService.swift
//  WikiBrowser
//
//  Created by u0835059 on 4/19/17.
//  Copyright © 2017 Samuel Davidson. All rights reserved.
//

import Foundation

class HttpService {
    init(){}
    public func getWikiPage(){
        let url = URL(string: "http://wikipedia.org")
        
        let urlRequest = URLRequest(url: url!)
        
        let config = URLSessionConfiguration.default
        
        let session = URLSession(configuration: config)
        
        
        
        let task = session.dataTask(with: urlRequest, completionHandler: requestHandler)
        
        task.resume()
        
    }
    
    public func requestHandler(data : Data?, response: URLResponse?, error: Error? ) {
        print("Returned")
        if let d = data, let r = response {
            print(r.expectedContentLength)
            //print(String(data: d, encoding: .utf8)!)
        }
    }
    
    
}
