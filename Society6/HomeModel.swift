//
//  HomeModel.swift
//  Society6
//
//  Created by Ampe on 1/28/17.
//  Copyright © 2017 Ampe. All rights reserved.
//

import Foundation

struct Post {

    var title: String
    var name: String
    var userImageURL: String
    var postImage: Data
    
}

struct Data {
    
    var postURL: String
    var postLikes: Int
    var postDate: Date
    
}
