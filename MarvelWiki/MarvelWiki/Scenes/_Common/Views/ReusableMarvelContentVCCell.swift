//
//  ReusableMarvelContentVCCell.swift
//  MarvelWiki
//
//  Created by Michelangelo Moncada on 20/02/25.
//

import UIKit

class ReusableMarvelContentVCCell: UICollectionViewCell {

    // MARK: - OUTLETS

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupCell(name: String, imageUrl: URL?) {
        nameLabel.text = name
        
        if let url = imageUrl {
            imageView.load(url: url)
        }
    }
}
