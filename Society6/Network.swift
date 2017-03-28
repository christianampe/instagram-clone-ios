//
//  Network.swift
//  Society6
//
//  Created by Ampe on 3/22/17.
//  Copyright © 2017 Ampe. All rights reserved.
//

import Foundation
import Parse

protocol HomeNetworkDelegate: class {
    func didFetchPosts(posts: [Post])
}

protocol ProfileNetworkDelegate: class {
    func didFetchProfile(posts: [Post])
    func didFetchHeaderData(header: Header)
}

class Networking {
    
    static let sharedInstance = Networking()
    
    weak var homeDelegate: HomeNetworkDelegate?
    weak var profileDelegate: ProfileNetworkDelegate?
    
    var posts = [Post]() {
        didSet { homeDelegate?.didFetchPosts(posts: posts) }
    }
    
    var profile = [Post]() {
        didSet { profileDelegate?.didFetchProfile(posts: profile) }
    }
    
    var header = Header() {
        didSet { profileDelegate?.didFetchHeaderData(header: header) }
    }
    
    public func post(imageData: UIImage, description: String) {
        let post = Post()
        let image = PFFile(name: "post.jpg", data:  UIImageJPEGRepresentation(imageData, 0.25)!)
        post.create(description: description, imageFile: image!)
        sendToServer(post: post)
    }
    
    public func fetch(className: String, limit: Int) {
        let query = PFQuery(className: className)
        query.limit = limit
        query.order(byDescending: "createdAt")
        query.findObjectsInBackground { (objects, error) in
            if let objects = objects {
                self.posts = self.map(objects: objects)
            }
        }
    }
    
    public func fetchProfilePosts(user: PFUser) {
        if let posts = user.object(forKey: "posts") as? [PFObject] {
            let count = posts.count
            var fetchedPosts = [PFObject]()
            for post in posts {
                post.fetchIfNeededInBackground { (post, error) in
                    if let pst = post {
                        fetchedPosts.append(pst)
                    }
                    if count == fetchedPosts.count {
                        self.profile = self.map(objects: fetchedPosts)
                    }
                }
            }
        }
    }
    
    public func fetchHeaderData(user: PFUser) {
        user.fetchInBackground { (usr, err) in
            if let user = usr {
                let header = Header()
//                header.image = user["profile_image"] as! PFFile?
//                header.description = user["description"] as! String?
                header.fullName = "Christian R. Ampe"
                header.description = "Water polo player from OC -> LA"
                header.posts = user["posts"] as? [PFObject]
                header.following = user["following"] as? [PFUser]
                header.followers = user["followers"] as? [PFUser]
                header.userName = user["username"] as? String
                self.header = header
            }
        }
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
            if success { self.updateUser(postFile: newPost) }
        }
    }
    
    private func updateUser(postFile: PFObject) {
        if let currentUser = PFUser.current() {
            currentUser.addUniqueObject(postFile, forKey: "posts")
            currentUser.saveInBackground {
                (success: Bool, error: Error?) -> Void in
            }
        }
    }
    
    private func map(objects: [PFObject]?) -> [Post] {
        var postsArray = [Post]()
        for object in objects! {
            let post = Post()
            post.date = object["date"] as! Date?
            post.likers = object["likers"] as! [PFUser]?
            post.commenters = object["commenters"] as! [PFUser]?
            post.description = object["description"] as! String?
            post.user = object["user"] as! PFUser?
            post.profileImage = object["profile_image"] as! PFFile?
            post.imageFile = object["image_file"] as! PFFile?
            post.id = object.objectId
            postsArray.append(post)
        }
        return postsArray
    }
}
