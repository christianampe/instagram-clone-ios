//
//  ProfileCVC.swift
//  Society6
//
//  Created by Ampe on 1/27/17.
//  Copyright © 2017 Ampe. All rights reserved.
//

import UIKit

class ProfileCVC: UICollectionViewController {
    
    let screenWidth = UIScreen.main.bounds.width
   
    var liked = [Array<Liked>]() {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    var headers: Header? {
        didSet { collectionView?.reloadData() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBodyData()
        loadHeaderData()
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return liked.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return liked[section].count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        let like = liked[indexPath.section][indexPath.row]
        
        if let likedCell = cell as? CollectionViewCell {
            likedCell.liked = like
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerview", for: indexPath) as! HeaderView
            headerView.user = headers
            return headerView
        default:
            assert(false, "Invalid Kind")
        }
    }
    
    private func loadHeaderData() {
        let header = Header(image: "emma4", posts: "2224", followers: "32.4K", following: "1.11K", fullName: "Christian R. Ampe", userName: "@christianampe", description: "water polo & piano player from the OC -> LA")
        headers = header
    }

    private func loadBodyData() {
        let data = Liked(likeImage: "emma4")
        liked = [[data,data,data,data,data,data,data,data,data,data,data,data]]
    }
}

extension ProfileCVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenWidth/3 - 2, height: screenWidth/3 - 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
}
