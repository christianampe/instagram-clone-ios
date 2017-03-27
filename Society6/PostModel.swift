//
//  HomePostModel.swift
//  Society6
//
//  Created by Ampe on 3/22/17.
//  Copyright © 2017 Ampe. All rights reserved.
//

import Foundation
import Parse

class Post {
   
    var description: String?
    var imageFile: PFFile?
    var date: Date?
    var likers: [PFUser]?
    var commenters: [PFUser]?
    var location: PFGeoPoint?
    var user: PFUser?
    var profileImage: PFFile?
    var id: String?
    
    func create(description: String, imageFile: PFFile) {
        self.description = description
        self.imageFile = imageFile
        self.date = Date()
        self.likers = []
        self.commenters = []
        self.location = PFGeoPoint(latitude: 0.0, longitude: 0.0)
        self.user = PFUser.current()!
        self.profileImage = imageFile
    }
    
}
