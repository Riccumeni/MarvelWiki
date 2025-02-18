//
//  Extension+UIView.swift
//  MarvelWiki
//
//  Created by Alessandro Riccumeni on 18/02/25.
//

import UIKit

extension UIView {
    private static let activityIndicatorTag = 999999
    
    
    /**
     Displays a loading indicator (`UIActivityIndicatorView`) in the center of the view.
     
     If an indicator already exists, it starts animating the existing one instead of adding a new one.

     - Parameter style: The style of the activity indicator. Defaults to `.medium`.

     ### Example Usage:
     ```swift
     myView.showLoadingIndicator()  // Displays a medium-sized spinner
     myView.showLoadingIndicator(style: .large)  // Displays a large spinner
     */
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
    
    /**
     Hides and removes the loading indicator (`UIActivityIndicatorView`) from the view.

     If no loading indicator is found, the function does nothing.

     ### Example Usage:
     ```swift
     myView.hideLoadingIndicator()  // Stops and removes the activity indicator if it exists
     */
    func hideLoadingIndicator() {
        if let indicator = viewWithTag(UIView.activityIndicatorTag) as? UIActivityIndicatorView {
            indicator.stopAnimating()
            indicator.removeFromSuperview()
        }
    }
}
