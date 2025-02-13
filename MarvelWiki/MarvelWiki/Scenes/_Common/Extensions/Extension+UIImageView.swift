//
//  Extension+UIImageView.swift
//  MarvelWiki
//
//  Created by Alessandro Riccumeni on 13/02/25.
//

import UIKit

extension UIImageView {
    
    /// Asynchronously loads an image from the given URL and sets it to the image view.
    ///
    /// This method fetches the image using `URLSession`, which automatically handles caching.
    ///
    /// - Parameter url: The URL from which to load the image.
    func load(url: URL) {
        let cache = URLCache.shared
            let request = URLRequest(url: url)
            
            if let cachedResponse = cache.cachedResponse(for: request),
               let image = UIImage(data: cachedResponse.data) {
                self.image = image
                return
            }
            
            URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                guard let data = data, error == nil, let image = UIImage(data: data), let response = response else {
                    return
                }
                
                let cachedResponse = CachedURLResponse(response: response, data: data)
                cache.storeCachedResponse(cachedResponse, for: request)
                
                DispatchQueue.main.async {
                    self?.image = image
                }
            }.resume()
    }
}
