//
//  SearchCollectionViewController.swift
//  Society6
//
//  Created by Ampe on 1/28/17.
//  Copyright © 2017 Ampe. All rights reserved.
//

import UIKit

class SearchCollectionViewController: UICollectionViewController, UIGestureRecognizerDelegate {
    
    var posts = [Array<Search>]() {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    @IBOutlet var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
     
        loadData()
        
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {

        return posts.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return posts[section].count
    }
    
    private struct Storyboard {
        static let Identifier = "cell"
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.Identifier, for: indexPath)
        
        let post = posts[indexPath.section][indexPath.row]
        
        if let postsCell = cell as? SearchCollectionViewCell {
            postsCell.search = post
        }
    
        return cell
    }
    
    func loadData() {
        let post = Search(imgURL: "emma1")
        posts = [[post,post,post,post,post,post,post,post,post,post,post,post,post,post,post,post,post,post,post,post,post,post,post,post,post,post]]
    }
    
}
