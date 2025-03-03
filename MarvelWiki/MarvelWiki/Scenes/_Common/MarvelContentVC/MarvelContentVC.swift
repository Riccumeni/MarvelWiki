//
//  MarvelContentVC.swift
//  MarvelWiki
//
//  Created by Michelangelo Moncada on 20/02/25.
//

import UIKit

protocol MarvelContentVCDelegate: AnyObject {
    func loadContent(marvelContentType: MarvelContentType, completion: @escaping ([MarvelContent], Bool) -> Void)
}


class MarvelContentVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var marvelContentType: MarvelContentType!
    
    private var marvelContents: [MarvelContent] = []
    private var filteredContents: [MarvelContent] = []
    
    weak var delegate: MarvelContentVCDelegate?
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(ReusableMarvelContentVCCell.nib(), forCellWithReuseIdentifier: ReusableMarvelContentVCCell.kReuseIdentifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Assign the search controller to the navigation item
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        // Configure search controller properties
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        
        loadData()
    }
    
    // MARK: - Private Methods
    
    private func loadData() {
        collectionView.showLoadingIndicator(style: .large)
        delegate?.loadContent(marvelContentType: marvelContentType, completion: { result, isSuccessful in 
            self.collectionView.hideLoadingIndicator()
            
            self.marvelContents = result
            self.filteredContents = result
            
            self.collectionView.reloadData()
        })
    }
    
}
    
// MARK: - Extensions CV

extension MarvelContentVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredContents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReusableMarvelContentVCCell.kReuseIdentifier, for: indexPath) as! ReusableMarvelContentVCCell
        let content = filteredContents[indexPath.row]
        cell.setupCell(name: content.title, imageUrl: URL(string: "\(content.thumbnail.path).\(content.thumbnail.urlExtension)"))
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

extension MarvelContentVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        defer {
            collectionView.reloadData()
        }
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            return
        }
        filteredContents = marvelContents.filter{ $0.title.starts(with: searchText) }
        print("Searching for: \(searchText)")
    }
}
