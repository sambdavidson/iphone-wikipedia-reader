//
//  WikiQueueTable.swift
//  WikiBrowser
//
//  Created by u0835059 on 4/27/17.
//  Copyright © 2017 Samuel Davidson. All rights reserved.
//

import UIKit

class WikiQueueTable: UIView, UITableViewDelegate, UITableViewDataSource {
    
    private var _wikiCollection:WikipediaCollection
    private var _tableView: UITableView = UITableView()
    
    init(frame fr: CGRect, wikiCollection wc:WikipediaCollection) {
        _wikiCollection = wc
        super.init(frame: fr)
        
        
        _tableView.frame = fr
        _tableView.delegate = self
        _tableView.dataSource = self
        _tableView.register(WikiQueueCell.self, forCellReuseIdentifier: "cell")
        
        _wikiCollection.RegisterOnPageAdded(self.onCollectionUpdated)
        _wikiCollection.RegisterOnPageRemoved(self.onCollectionUpdated)
        _wikiCollection.RegisterOnActivePageChange(self.onCollectionUpdated)
        _wikiCollection.RegisterOnPageUpdated(self.onCollectionUpdated)
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        _tableView.addGestureRecognizer(longPressRecognizer)
        
        addSubview(_tableView)
        
    }
    
    func longPress(longPressGestureRecognizer: UILongPressGestureRecognizer) {
        if longPressGestureRecognizer.state == .began {
            let rowIndex = _tableView.indexPathForRow(at: longPressGestureRecognizer.location(in: _tableView))
            if let r = rowIndex {
                let cell:WikiQueueCell = _tableView.cellForRow(at: r) as! WikiQueueCell
                if let p = cell.wikipage {
                    _wikiCollection.ToggleLockingOf(page: p)
                }
            }
        }
        
    }
    
    public func updateFrame(_ f:CGRect) {
        frame = f
        _tableView.frame = f
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _wikiCollection.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:WikiQueueCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as! WikiQueueCell
        
        let wikiPage = _wikiCollection.GetPageAtOffset(indexPath.row)
        
        cell.indentationWidth = 15.0
        
        if let p = wikiPage {
            cell.wikipage = p
            cell.indentationLevel = min(p.depth, 15)
            if p.articleName == _wikiCollection.activePage.articleName {
                cell.backgroundColor = UIColor(red: 0, green: 122.0/255, blue: 1.0, alpha: 1.0)
                cell.textLabel?.textColor = UIColor.white
            } else {
                cell.backgroundColor = UIColor.white
                cell.textLabel?.textColor = UIColor(red: 0, green: 122.0/255, blue: 1.0, alpha: 1.0)
            }
            if !p.loaded {
                cell.textLabel?.textColor = UIColor.lightGray
                cell.textLabel?.text = "⏳\(p.articleName)"
            } else if p.locked {
                cell.textLabel?.text = "🔒\(p.articleName)"
            } else if p.unviewed {
                cell.textLabel?.text = "\(p.bookFlair)\(p.articleName)"
            } else {
                cell.textLabel?.text = "📖\(p.articleName)"
            }
            
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            let wikiPage = _wikiCollection.GetPageAtOffset(indexPath.row)
            
            if let p = wikiPage {
                _wikiCollection.RemovePage(wiki: p)
            }
        }
    }
    
    public func onCollectionUpdated(_ p:Wikipage?) {
        _tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let wikiPage = _wikiCollection.GetPageAtOffset(indexPath.row)
        
        if let p = wikiPage {
            if p.loaded {
                _wikiCollection.SetActive(page: p)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
