//
//  ViewController.swift
//  LibrarySample
//
//  Created by onishi on 2016/10/31.
//  Copyright © 2016年 sample. All rights reserved.
//

import UIKit
import Whisper
import PullToRefresh

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private let reuserIdentifier: String = "ReuseIdent"
    var names: [String] = ["いち", "にー", "さん", "よん", "ごー", "ろく"]
    var updateCnt = 0;
    
    let pullToRefresh = PullToRefresh()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden = true
        // Refresh
        self.tableView.addPullToRefresh(self.pullToRefresh) {
            if self.updateCnt < 5 { // 5回まで更新可能とする
                self.updateCnt += 1
                self.names.append("更新\(self.updateCnt)回目ー")
                self.tableView.reloadData()
                self.tableView.endRefreshing(at: .Top)
            } else {
                show(shout: Announcement(title: "もう更新できないよ！"), to: self)
                self.tableView.endRefreshing(at: .Top)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let msg = names[indexPath.row] + "選択されたよー"
        let anc: Announcement = Announcement(title: msg)
        show(shout: anc, to: self)
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(self.reuserIdentifier)
            
        if cell == nil {
            cell = UITableViewCell()
        }
        cell!.textLabel?.text = names[indexPath.row]
        return cell!
    }
}