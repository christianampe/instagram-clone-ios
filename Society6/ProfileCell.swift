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
    
    var post: Post? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        
        imageView.image = nil
        
        if let post = self.post {
            
            if let postFile = post.imageFile {
                postFile.getDataInBackground { (data, error) in
                    if let data = data {
                        self.imageView.image = UIImage(data: data)!
                    }
                }
            }
        }
    }
    
}
