//
//  HomeTableViewController.swift
//  Society6
//
//  Created by Ampe on 1/26/17.
//  Copyright © 2017 Ampe. All rights reserved.
//

import UIKit
import Fusuma

class HomeTableViewController: UITableViewController {
    
    var posts = [Array<Post>]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPosts()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return posts.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return posts[section].count
    }
    
    private struct Storyboard {
        static let PostIdentifier = "cell"
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.PostIdentifier, for: indexPath)

        let post = posts[indexPath.section][indexPath.row]
        
        if let postCell = cell as? HomeTableViewCell {
            postCell.post = post
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let post = posts[indexPath.section][indexPath.row]
        return calculateHeight(img: UIImage(named: (post.postImage.postURL))!)  + 124
    }
    
    func setPosts() {
        let post = Post(title: "Inception", name: "Christian R. Ampe", userImageURL: "emma4", postImage: Data(postURL: "emma4", postLikes: 393617, postDate: Date(timeIntervalSince1970: 100)))
        posts = [[post,post,post,post,post,post,post,post,post,post,post,post,post,post,post]]
    }
    
    func calculateHeight(img: UIImage) -> CGFloat {
        
        let width: CGFloat = img.size.width
        let height: CGFloat = img.size.height
        let scale: CGFloat = width / height
        
        let screenSize = UIScreen.main.bounds
        let imageWidth = screenSize.width
        let imageHeight = imageWidth / scale
        
        return imageHeight
    }
    
}
