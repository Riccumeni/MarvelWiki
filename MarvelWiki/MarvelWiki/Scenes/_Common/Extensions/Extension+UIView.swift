//
//  Extension+UIView.swift
//  MarvelWiki
//
//  Created by Alessandro Riccumeni on 18/02/25.
//

import UIKit

extension UIView {
    private static let activityIndicatorTag = 999999
    
    func showLoadingIndicator(style: UIActivityIndicatorView.Style = .medium){
        
        if let existingIndicator = viewWithTag(UIView.activityIndicatorTag) as? UIActivityIndicatorView {
            existingIndicator.startAnimating()
            return
        }
        
        let indicator = UIActivityIndicatorView(style: style)
        indicator.tag = UIView.activityIndicatorTag
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        addSubview(indicator)

        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        indicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        if let indicator = viewWithTag(UIView.activityIndicatorTag) as? UIActivityIndicatorView {
            indicator.stopAnimating()
            indicator.removeFromSuperview()
        }
    }
}
