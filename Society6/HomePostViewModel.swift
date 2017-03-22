//
//  HomePostViewModel.swift
//  Society6
//
//  Created by Ampe on 3/22/17.
//  Copyright © 2017 Ampe. All rights reserved.
//

import Foundation

struct HomePostViewModel {
    
    // Post Model
    private var homePost: HomePostModel
    
    // User Model
    private var homePostUser: UserModel {
        return homePost.user
    }
    var userProfileImage: URL? {
        return URL(string: homePostUser.profileURL)
    }
    var userName: String? {
        return homePostUser.userName
    }
    
    // Post Data Model
    private var homePostData: HomePostDataModel {
        return homePost.data
    }
    var location: (Int,Int)? {
        return homePostData.location
    }
    var likeDescription: String? {
        return "Liked by \(homePostData.likeCount) users"
    }
    var description: String? {
        return "\(userName): \(homePostData.description)"
    }
    var timeSince: String? {
        return homePostData.date.timeIntervalSinceNow.description
    }
    
    // Post Image Model
    private var homePostImage: ImageModel {
        return homePost.image
    }
    var postImage: URL? {
        return URL(string: homePostImage.imageURL)
    }
    var aspectRatio: Float? {
        return homePostImage.width / homePostImage.height
    }
    
}
