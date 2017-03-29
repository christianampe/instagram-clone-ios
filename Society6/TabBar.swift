//
//  TabBar.swift
//  Society6
//
//  Created by Ampe on 3/27/17.
//  Copyright © 2017 Ampe. All rights reserved.
//

import UIKit
import Parse

class TabBar: UITabBarController {
    
    let networking = Networking.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        networking.fetch(className: "Posts", limit: 25)
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == (self.tabBar.items?[0]) {
            networking.fetch(className: "Posts", limit: 25)
        }
        if item == (self.tabBar.items?[1]) { }
        if item == (self.tabBar.items?[2]) {
            networking.fetchProfilePosts(user: PFUser.current()!)
            networking.fetchHeaderData(user: PFUser.current()!)
        }
    }

}
