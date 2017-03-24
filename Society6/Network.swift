//
//  Network.swift
//  Society6
//
//  Created by Ampe on 3/22/17.
//  Copyright © 2017 Ampe. All rights reserved.
//

import Foundation
import Parse

protocol NetworkDelegate: class {
    func didFetchPosts(posts: [Post])
}

class Networking {
    
    static let sharedInstance = Networking()
    weak var delegate: NetworkDelegate?
    
    var posts = [Post]() {
        didSet { delegate?.didFetchPosts(posts: posts) }
    }
    
    public func post(imageData: UIImage, description: String) {
        let post = Post()
        let image = PFFile(name: "post.jpg", data:  UIImageJPEGRepresentation(imageData, 0.25)!)
        post.create(description: description, imageFile: image!)
        sendToServer(post: post)
    }
    
    private func sendToServer(post: Post) {
        let newPost = PFObject(className: "Posts")
        newPost["date"] = post.date
        newPost["likers"] = post.likers
        newPost["commenters"] = post.commenters
        newPost["description"] = post.description
        newPost["user"] = post.user
        newPost["profile_image"] = post.profileImage
        newPost["image_file"] = post.imageFile
        newPost.saveInBackground {
            (success: Bool, error: Error?) -> Void in
        }
    }
    
    public func fetch() {
        let query = PFQuery(className: "Posts")
        query.limit = 25
        query.order(byDescending: "createdAt")
        query.findObjectsInBackground { (objects, error) in
            self.map(objects: objects!)
        }
    }
    
    private func map(objects: [PFObject]) {
        var postsArray = [Post]()
        for object in objects {
            let post = Post()
            post.date = object["date"] as! Date?
            post.likers = object["likers"] as! [PFUser]?
            post.commenters = object["commenters"] as! [PFUser]?
            post.description = object["description"] as! String?
            post.user = object["user"] as! PFUser?
            post.profileImage = object["profile_image"] as! PFFile?
            post.imageFile = object["image_file"] as! PFFile?
            postsArray.append(post)
        }
        self.posts = postsArray
    }
}
