//
//  CollectionViewController.swift
//  Society6
//
//  Created by Ampe on 1/27/17.
//  Copyright © 2017 Ampe. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    
    var liked = [Array<Liked>]() {
        didSet {
            collectionView?.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return liked.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return liked[section].count
    }

    private struct Storyboard {
        static let Identifier = "cell"
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.Identifier, for: indexPath)
    
        let like = liked[indexPath.section][indexPath.row]
        
        if let likedCell = cell as? CollectionViewCell {
            likedCell.liked = like
        }
    
        return cell
    }
    
    private func loadData() {
        let data = Liked(likeImage: "emma1")
        liked = [[data,data,data,data,data,data,data,data,data,data,data,data,data,data,data,data,data,data,data,data,data,data,data,data,data,data,data,data,data,data,data,data,data,data,data,data]]
    }

}
