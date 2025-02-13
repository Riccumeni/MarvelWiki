//
//  SeriesCollectionViewCell.swift
//  MarvelWiki
//
//  Created by Alessandro Riccumeni on 13/02/25.
//

import UIKit

class SeriesCVC: UICollectionViewCell {
    
    // MARK: - Outlets

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(title: String){
        titleLabel.text = title
    }
}
