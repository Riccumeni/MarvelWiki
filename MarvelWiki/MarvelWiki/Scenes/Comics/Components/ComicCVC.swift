//
//  ComicCVC.swift
//  MarvelWiki
//
//  Created by Alessandro Riccumeni on 13/02/25.
//

import UIKit

class ComicCVC: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var comicImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupCell(imageUrl: URL?) {
        if let url = imageUrl {
            comicImageView.load(url: url)
        }
    }
}

