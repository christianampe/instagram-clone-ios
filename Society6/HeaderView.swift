//
//  HeaderView.swift
//  Society6
//
//  Created by Ampe on 1/29/17.
//  Copyright © 2017 Ampe. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var postCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var descritionLabel: UILabel!
    
    var user: Header? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        
        profileImageView.image = nil
        postCountLabel.text = nil
        followerCountLabel.text = nil
        followingCountLabel.text = nil
        fullNameLabel.text = nil
        userNameLabel.text = nil
        descritionLabel.text = nil
        
        if let user = self.user {
            profileImageView.image = UIImage(named: user.image)
            postCountLabel.text = user.posts
            followerCountLabel.text = user.followers
            followingCountLabel.text = user.following
            fullNameLabel.text = user.fullName
            userNameLabel.text = user.userName
            descritionLabel.text = user.description
        }
    }
    
}
