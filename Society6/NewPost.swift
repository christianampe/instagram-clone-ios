//
//  NewPostViewController.swift
//  Society6
//
//  Created by Ampe on 3/22/17.
//  Copyright © 2017 Ampe. All rights reserved.
//

import UIKit
import Fusuma

class NewImageView: UIImageView {}
class ImageDescription: UITextView {}

class NewPostViewController: UIViewController {
    
    let neworking = Networking()

    @IBOutlet weak var imageView: NewImageView!
    @IBOutlet weak var imageDescription: ImageDescription!
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendButtonTapped(_ sender: UIButton) {
        endEditing()
        neworking.post(imageData: imageView.image!, description: imageDescription.text)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        let fusuma = FusumaViewController()
        fusuma.delegate = self
        fusumaTintColor = .white
        fusumaCropImage = false
        present(fusuma, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func endEditing() {
        view.endEditing(true)
    }

}

extension NewPostViewController: FusumaDelegate {
    func fusumaImageSelected(_ image: UIImage, source: FusumaMode) {
        switch source {
        case .camera: break
        case .library: break
        default: break
        }
        imageView.image = image
    }
    
    func fusumaDismissedWithImage(_ image: UIImage, source: FusumaMode) {
        switch source {
        case .camera: break
        case .library: break
        default: break
        }
    }
    
    func fusumaCameraRollUnauthorized() {
        let alert = UIAlertController(title: "Access Requested", message: "Saving image needs to access your photo album", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { (action) -> Void in
            if let url = URL(string:UIApplicationOpenSettingsURLString) {
                UIApplication.shared.open(url, completionHandler: nil)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func fusumaClosed() {}
    
    func fusumaWillClosed() {}
    
    func fusumaVideoCompleted(withFileURL fileURL: URL) {}
    
}

