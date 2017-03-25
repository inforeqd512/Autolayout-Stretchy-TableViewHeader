//
//  ViewController.swift
//  StretchHeader
//
//  Created by Info Reqd on 25/3/17.
//  Copyright © 2017 Info Reqd. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    @IBOutlet var headerView: HeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.tableHeaderView = self.headerView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let headerView = self.tableView.tableHeaderView as! HeaderView
        headerView.containerViewDidScroll(ToOffset: scrollView.contentOffset, withInset: scrollView.contentInset)
    }

}

