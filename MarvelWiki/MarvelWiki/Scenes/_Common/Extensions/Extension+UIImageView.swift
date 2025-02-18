//
//  Extension+UIImageView.swift
//  MarvelWiki
//
//  Created by Alessandro Riccumeni on 13/02/25.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    /**
     Loads an image from the provided URL and sets it to the `UIImageView`.

     Displays a loading indicator while the image is being fetched. The `placeholderImage` is shown until the image is loaded. Once the image is loaded, the loading indicator is hidden.

     - Parameters:
        - url: The URL from which the image will be loaded.
        - placeholderAssetName: The name of the placeholder image to display while the image is loading. Defaults to `"placeholder_no_image"`.

     ### Example Usage:
     ```swift
     imageView.load(url: URL(string: "https://example.com/image.jpg")!)
     imageView.load(url: URL(string: "https://example.com/image.jpg")!, placeholderAssetName: "custom_placeholder")
     */
    func load(url: URL, placeholderAssetName: String = "placeholder_no_image") {
        self.showLoadingIndicator()
        
        self.sd_setImage(with: url, placeholderImage: UIImage(named: placeholderAssetName) ,completed: { _,_,_,_ in
            self.hideLoadingIndicator()
        })
    }
}
