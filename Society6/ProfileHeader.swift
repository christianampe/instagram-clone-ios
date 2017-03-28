//
//  HeaderView.swift
//  Society6
//
//  Created by Ampe on 1/29/17.
//  Copyright © 2017 Ampe. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var postCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var descritionLabel: UILabel!
    
    var header: Header? {
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
        
        if let header = self.header {
            
            if let postFile = header.image {
                postFile.getDataInBackground { (data, error) in
                    if let data = data {
                        self.profileImageView.image = UIImage(data: data)!
                    }
                }
            }
            
            postCountLabel.text = header.posts?.count.description
            followerCountLabel.text = header.followers?.count.description
            followingCountLabel.text = header.following?.count.description
            fullNameLabel.text = header.fullName
            
            if let usrnm = header.userName {
                userNameLabel.text = "@\(usrnm)"
            }
            
            descritionLabel.text = header.description
            
        }
    }
    
}
