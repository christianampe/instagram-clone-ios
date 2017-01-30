//
//  ProfileTableViewController.swift
//  Society6
//
//  Created by Ampe on 1/28/17.
//  Copyright © 2017 Ampe. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {
    
    @IBOutlet weak var headerView: HeaderView!
    
    var headers: Header? {
        didSet {
            headerView.user = headers
        }
    }
    
    var activities = [Array<Activity>]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return activities.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return activities[section].count
    }

    private struct Storyboard {
        static let PostIdentifier = "cell"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.PostIdentifier, for: indexPath)
        
        let activity = activities[indexPath.section][indexPath.row]
        
        if let activtyCell = cell as? ProfileTableViewCell {
            activtyCell.activity = activity
        }

        return cell
    }
    
    private func loadData() {
        let data = Activity(userImageURL: "emma3", userName: "@ampechristian", postImageURL: "emma4", date: NSDate(timeIntervalSince1970: 10000))
        
        activities = [[data,data,data,data,data,data,data,data,data,data,data,data,data,data,data,data,data,data,data,data,data,data,data,data,data,data,data,data,data,data,data,data,data,data]]
        
        let header = Header(image: "emma4", posts: "2224", followers: "32.4K", following: "1.11K", fullName: "Ampe R. Christian", userName: "@christianampe", description: "water polo & piano player from the OC -> LA")
        
        headers = header
        
        
    }

}
