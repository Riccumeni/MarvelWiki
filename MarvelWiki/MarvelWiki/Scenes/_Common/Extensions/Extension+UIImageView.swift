//
//  Extension+UIImageView.swift
//  MarvelWiki
//
//  Created by Alessandro Riccumeni on 13/02/25.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    /// Asynchronously loads an image from the given URL and sets it to the image view.
    ///
    /// This method fetches the image using `SDWebImage`, which automatically handles caching.
    ///
    /// - Parameter url: The URL from which to load the image.
    func load(url: URL, placeholderAssetName: String = "placeholder_no_image") {
        self.showLoadingIndicator()
        
        self.sd_setImage(with: url, placeholderImage: UIImage(named: placeholderAssetName) ,completed: { _,_,_,_ in
            self.hideLoadingIndicator()
        })
    }
}
