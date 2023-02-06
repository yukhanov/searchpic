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
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Search images"

        
        setViews()
        setConstraints()
        listViewModel.fetchImages(collectionView: collectionView!)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            print(self.listViewModel.imagesArray)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }


}

extension ImageListViewController: UICollectionViewDataSource {
    
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
        view.addSubview(collectionView)
        self.collectionView = collectionView
    }
    
    func setConstraints() {
        
    }
}

