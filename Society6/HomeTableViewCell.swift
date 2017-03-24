//
//  HomeTableViewCell.swift
//  Society6
//
//  Created by Ampe on 1/28/17.
//  Copyright © 2017 Ampe. All rights reserved.
//

import UIKit
import Parse

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
        
        imgView.image = nil
        userImage.image = nil
        title.text = nil
        userName.text = nil
        likes.text = nil
        
        if let post = self.post {

            if let postFile = post.imageFile {
                postFile.getDataInBackground { (data, error) in
                    if let data = data {
                        self.imgView.image = UIImage(data: data)!
                    }
                }
            }
            
            if let profileImage = post.profileImage {
                profileImage.getDataInBackground { (data, error) in
                    if let data = data {
                        self.userImage.image = UIImage(data: data)!
                    }
                }
            }
            
            title.text = "ampechristian"
            userName.text = post.description
            likes.text = post.likers?.count.description
        }
    }
}
