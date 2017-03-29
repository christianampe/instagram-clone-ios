//
//  ProfileCVC.swift
//  Society6
//
//  Created by Ampe on 1/27/17.
//  Copyright © 2017 Ampe. All rights reserved.
//

import UIKit
import Parse

class ProfileCVC: UICollectionViewController {
    
    let screenWidth = UIScreen.main.bounds.width
    let refreshControl = UIRefreshControl()
    
    var profile = PFUser() { didSet { refresh(); setConstant() } }
    var posts = [Post]() { didSet { collectionView?.reloadData(); refreshControl.endRefreshing() } }
    var header = Header() { didSet { collectionView?.reloadData() } }
    
    private func setUp() {
        Networking.sharedInstance.profileDelegate = self
        refreshControl.addTarget(self, action:#selector(refresh), for: .valueChanged)
        collectionView?.addSubview(refreshControl)
    }
    
    // TODO: - Move Into Separate File
    private func setConstant() {
        profile.fetchIfNeededInBackground(block: { (data, error) in
            var email = data?["email"] as! String
            if let range = email.range(of: "@") {
                email.removeSubrange(range.lowerBound..<email.endIndex)
                self.title = email
            }
        })
    }
    
    @objc private func refresh() {
        Networking.sharedInstance.fetchProfilePosts(user: profile)
        Networking.sharedInstance.fetchHeaderData(user: profile)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    // MARK: - Data Source
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let post = posts[indexPath.row]
        if let postsCell = cell as? CollectionViewCell {
            postsCell.post = post
        }
        return cell
    }
    
    // MARK: - Delegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "imagevc") as? HomeTableViewController {
            controller.posts = [self.posts[indexPath.row]]
            self.show(controller, sender: nil)
        }
    }
    
    // MARK: - Header View
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerview", for: indexPath) as! HeaderView
            headerView.header = header
            return headerView
        default:
            assert(false, "Invalid Kind")
        }
    }
}

extension ProfileCVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { return CGSize(width: screenWidth/3 - 1.0, height: screenWidth/3 - 1.0) }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { return 0.5 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { return 0.5 }
}

extension ProfileCVC: ProfileNetworkDelegate {
    func didFetchProfile(posts: [Post]) { self.posts = posts }
    func didFetchHeaderData(header: Header) { self.header = header  }
}
