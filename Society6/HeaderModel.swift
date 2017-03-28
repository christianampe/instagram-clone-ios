//
//  HeaderModel.swift
//  Society6
//
//  Created by Ampe on 1/29/17.
//  Copyright © 2017 Ampe. All rights reserved.
//

import Foundation
import Parse

class Header {
    
    var image: PFFile?
    var posts: [PFObject]?
    var followers: [PFUser]?
    var following: [PFUser]?
    var fullName: String?
    var userName: String?
    var description: String?
    
}
