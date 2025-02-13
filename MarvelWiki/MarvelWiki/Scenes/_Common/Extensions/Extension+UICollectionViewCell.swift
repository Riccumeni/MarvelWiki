//
//  Extension+UICollectionViewCell.swift
//  MarvelWiki
//
//  Created by Alessandro Riccumeni on 13/02/25.
//

import UIKit

extension UICollectionViewCell {
    
    static var kReuseIdentifier: String {
        get {
            return String(describing: self)
        }
    }
    
    static func nib() -> UINib{
        return UINib(nibName: kReuseIdentifier, bundle: nil)
    }
}
