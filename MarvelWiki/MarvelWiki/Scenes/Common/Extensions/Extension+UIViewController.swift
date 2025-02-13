//
//  Extension+UIViewController.swift
//  MarvelWiki
//
//  Created by Alessandro Riccumeni on 13/02/25.
//

import UIKit

extension UIViewController {
    /// Creates a new instance of the view controller with a specified title and tab bar item image.
    ///
    /// This method initializes a new instance of the view controller and sets its title and tab bar item image.
    ///
    /// - Parameters:
    ///   - title: The title to be set for the view controller.
    ///   - imageName: The name of the system image to be used for the tab bar item.
    /// - Returns: A new instance of the view controller with the specified title and tab bar image.
    ///
    /// - Note: This method assumes that the view controller can be initialized using `init()`. If the view controller is instantiated from a storyboard, this method may not work correctly.
    static func newInstance(title: String, imageName: String) -> UIViewController {
        let vc = self.init()
        
        vc.title = title
        vc.tabBarItem.image = UIImage(systemName: imageName)
        
        return vc
    }
}
