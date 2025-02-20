//
//  MarvelContentVC.swift
//  MarvelWiki
//
//  Created by Michelangelo Moncada on 20/02/25.
//

import UIKit

protocol MarvelContentVCDelegate: AnyObject {
    func loadMarvelContent(completion: @escaping ([MarvelContent], Bool) -> Void)
}


class MarvelContentVC: UIViewController {
    
    @IBOutlet weak var characterCollectionView: UICollectionView!
    
    private var marvelContentType: MarvelContentType
    
    private var marvelContents: [MarvelContent] = []
    
    weak var delegate: MarvelContentVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        characterCollectionView.register(ReusableMarvelContentVCCell.nib(), forCellWithReuseIdentifier: ReusableMarvelContentVCCell.kReuseIdentifier)
        
        loadData()
    }

    // MARK: - Private Methods
        
    private func loadData() {
        characterCollectionView.showLoadingIndicator(style: .large)
        delegate?.loadCharacters(completion: { result, isSuccessful in  // Gestico il tipo di load da fare: a che livello conviene farlo?
            self.characterCollectionView.hideLoadingIndicator()
            self.characters = result
            self.characterCollectionView.reloadData()
        })
    }
    
    // MARK: - Extensions CV

    extension MarvelContentVC: UICollectionViewDelegate, UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return marvelContents.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReusableMarvelContentVCCell.kReuseIdentifier, for: indexPath) as! ReusableMarvelContentVCCell
            
            let marvelContent = marvelContents[indexPath.row]
            
            cell.setupCell(name: marvelContent.name, imageUrl: URL(string: "\(marvelContent.thumbnail.path).\(marvelContent.thumbnail.urlExtension)"))
            
            return cell
        }
    }

    extension MarvelContentVC: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {
            let itemsPerRow: CGFloat = 3
            let padding: CGFloat = 10
            let totalSpacing = padding * (itemsPerRow - 1)
            let availableWidth = collectionView.frame.width - totalSpacing
            let widthPerItem = availableWidth / itemsPerRow
            return CGSize(width: widthPerItem, height: widthPerItem)
        }
    }

}
