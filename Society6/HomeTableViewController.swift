//
//  HomeTableViewController.swift
//  Society6
//
//  Created by Ampe on 1/26/17.
//  Copyright © 2017 Ampe. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    let network = Networking()
    
    var posts = [Post]() {
        didSet { tableView.reloadData() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        network.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        network.fetch()
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
            postCell.post = post
        }
        return cell
    }
}

extension HomeTableViewController: NetworkDelegate {
    func didFetchPosts(posts: [Post]) {
        self.posts = posts
    }
}
