//
//  CollectionViewCell.swift
//  Society6
//
//  Created by Ampe on 1/27/17.
//  Copyright © 2017 Ampe. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var liked: Liked? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        
        imageView.image = nil
        
        if let liked = self.liked {
            imageView.image = UIImage(named: liked.likeImage)
        }
    }
    
}
