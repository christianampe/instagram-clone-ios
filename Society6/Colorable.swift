//
//  Colorable.swift
//  Society6
//
//  Created by Ampe on 3/22/17.
//  Copyright © 2017 Ampe. All rights reserved.
//

import UIKit

protocol Colorable {}

extension Colorable where Self: UILabel {
    
    func color(from: UIColor, to: UIColor) {
        UILabel.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            self.alpha = 0.0
            self.textColor = to
        }) { (bool) in
            if bool {
                UILabel.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
                    self.alpha = 1.0
                    self.textColor = from
                }, completion: nil)
            }
        }
    }
    
}
