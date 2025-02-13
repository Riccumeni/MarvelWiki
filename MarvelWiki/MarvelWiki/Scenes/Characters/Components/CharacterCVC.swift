//
//  CharacterCVC.swift
//  MarvelWiki
//
//  Created by Alessandro Riccumeni on 13/02/25.
//

import UIKit

class CharacterCVC: UICollectionViewCell {
    
    static let kReuseIdenitifier = "CharacterCVC"
    
    static func nib() -> UINib{
        return UINib(nibName: CharacterCVC.kReuseIdenitifier, bundle: nil)
    }
    
    // MARK: - OUTLETS

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heroImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupCell(name: String, imageUrl: URL?) {
        nameLabel.text = name
        
        if let url = imageUrl {
            heroImageView.load(url: url)
        }
    }
}
