//
//  ViewController.swift
//  SearchPic
//
//  Created by Сергей Юханов on 06.02.2023.
//

import UIKit

class ImageListViewController: UIViewController, Coordinating {
    var coordinator: Coordinator?
    var listViewModel = ListViewModel()
    
    private var collectionView: UICollectionView?
    private var searchBar = UISearchBar()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Search images"

        
        setViews()
        setConstraints()
        //listViewModel.fetchImages(collectionView: collectionView!)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            print(self.listViewModel.imagesArray)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchBar.frame = CGRect(x: 20, y: view.safeAreaInsets.top, width: view.frame.size.width-20, height: 50)
        collectionView?.frame = CGRect(x: 0, y: view.safeAreaInsets.top+55, width: view.frame.size.width, height: view.frame.size.height-55)
    }


}

extension ImageListViewController: UICollectionViewDataSource, UISearchBarDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        listViewModel.imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let errorURL = "https://sun1-84.userapi.com/s/v1/if1/HlmZlxTY1aqV2tNHGqipjvB_diKiH42VBgDIh8qnpmiVruBF8uZTZEdQISQtdrwwyEal4NS5.jpg?size=200x200&quality=96&crop=62,15,450,450&ava=1"
        let imageURL = listViewModel.imagesArray[indexPath.row].thumbnail ?? errorURL
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell()}
        cell.configure(with: imageURL)
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let text = searchBar.text {
            listViewModel.fetchImages(collectionView: collectionView!, g: text)
        }
    }
    
    func setViews() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: view.frame.size.width/2,
                                 height: view.frame.size.width/2)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        collectionView.dataSource = self
        searchBar.delegate = self
        view.addSubview(collectionView)
        view.addSubview(searchBar)
        self.collectionView = collectionView
    }
    
    func setConstraints() {
        
    }
}

