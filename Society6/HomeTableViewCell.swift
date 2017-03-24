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
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeSince: UILabel!
    
    var post: Post? {
        didSet { updateUI() }
    }
    
    private func updateUI() {
        
        imgView.image = nil
        userImage.image = nil
        title.text = nil
        userName.text = nil
        likes.text = nil
        descriptionLabel.text = nil
        timeSince.text = nil
        
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
            
            if let userName = post.user {
                userName.fetchIfNeededInBackground(block: { (data, error) in
                    var email = data?["email"] as! String
                    if let range = email.range(of: "@") {
                        email.removeSubrange(range.lowerBound..<email.endIndex)
                        self.title.text = email
                    } 
                })
            }
            
            if let time = post.date {
                var val: Int = 0
                var string = ""
                let sec = abs(time.timeIntervalSinceNow)
                if (sec/60) < 60 {
                    val = Int(sec/60)
                    string = "minutes ago"
                }
                else if (sec/3600) < 24 {
                    val = Int(sec/3600)
                    string = "hours ago"
                }
                else {
                    val = Int(sec/86400)
                    string = "days ago"
                }
                timeSince.text = "Posted \(val.description) \(string)"
            }
            
            userName.text = "Los Angeles"
            
            if let likeString = post.likers?.count.description {
                likes.text = "\(likeString) likes"
            }
            
            if let desc = post.description {
                descriptionLabel.text = "\(desc)"
            }
            
        }
    }
}
