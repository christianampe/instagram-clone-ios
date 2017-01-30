//
//  SearchCollectionViewCell.swift
//  Society6
//
//  Created by Ampe on 1/28/17.
//  Copyright © 2017 Ampe. All rights reserved.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var search: Search? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        
        imageView.image = nil
        
        if let search = self.search {
            imageView.image = UIImage(named: search.imgURL)
        }
    }
    
}
