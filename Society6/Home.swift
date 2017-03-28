//
//  HomeTableViewController.swift
//  Society6
//
//  Created by Ampe on 1/26/17.
//  Copyright © 2017 Ampe. All rights reserved.
//

import UIKit
import Parse

class HomeTableViewController: UITableViewController {
    
    let refresh = UIRefreshControl()
    
    var posts = [Post]() { didSet { refresh.endRefreshing(); tableView.reloadData() } }
    
    private func setUp() {
        Networking.sharedInstance.homeDelegate = self
        refresh.addTarget(self, action:#selector(reload), for: .valueChanged)
        tableView.addSubview(refresh)
    }
    
    @objc private func reload() {
        print("reload")
        Networking.sharedInstance.fetch(className: "Posts", limit: 25)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    // MARK: - Data Source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let post = posts[indexPath.row]
        if let postCell = cell as? HomeTableViewCell {
            postCell.delegate = self
            postCell.post = post
        }
        return cell
    }
    
}

extension HomeTableViewController: HomeNetworkDelegate {
    func didFetchPosts(posts: [Post]) { self.posts = posts }
}

extension HomeTableViewController: UserTappedDelegate {
    func userTapped(user: PFUser) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "profile") as? ProfileCVC {
            controller.profile = user
            self.show(controller, sender: nil)
        }
    }
}
