//
//  HomeTableViewCell.swift
//  Society6
//
//  Created by Ampe on 1/28/17.
//  Copyright © 2017 Ampe. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var likes: UILabel!
    
    var post: Post? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        
        // reset all attributes to nil
        imgView.image = nil
        userImage.image = nil
        title.text = nil
        userName.text = nil
        likes.text = nil
        
        if let post = self.post {
            imgView.image = UIImage(named: post.postImage.postURL)
            userImage.image = UIImage(named: post.userImageURL)
            title.text = post.title
            userName.text = post.name
            likes.text = String(describing: post.postImage.postLikes)
        }
    }
}
