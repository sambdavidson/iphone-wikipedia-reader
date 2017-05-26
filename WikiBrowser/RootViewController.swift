//
//  ViewController.swift
//  WikiBrowser
//
//  Created by u0835059 on 4/19/17.
//  Copyright © 2017 Samuel Davidson. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    let webService:HttpService = HttpService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(frame: CGRect(x: 30, y: 100, width: 300, height: 100))
        button.setTitle("DownloadTest", for: .normal)
        button.addTarget(self, action: #selector(click), for: .touchUpInside)
        
        
        view.addSubview(button)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func click() {
        NSLog("Requesting");
        webService.getWikiPage()
    }


}

