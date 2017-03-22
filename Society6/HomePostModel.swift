//
//  HomePostModel.swift
//  Society6
//
//  Created by Ampe on 3/22/17.
//  Copyright © 2017 Ampe. All rights reserved.
//

import Foundation

struct HomePostModel {
    
    var user: UserModel
    var image: ImageModel
    var data: HomePostDataModel
    
}

struct HomePostDataModel {
    
    var date: Date
    var likeCount: Int
    var description: String
    var location: (Int, Int)
    
}

struct UserModel {
    
    var userName: String
    var profileURL: String
    
}

struct ImageModel {
    
    var imageURL: String
    var height: Float
    var width: Float

}
