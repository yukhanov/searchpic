//
//  ListViewModel.swift
//  SearchPic
//
//  Created by Сергей Юханов on 06.02.2023.
//

import Foundation
import UIKit

class ListViewModel {
    let networkManager = NetworkManager()
    var imagesArray = [ImagesResult]()
    

    func fetchImages(collectionView: UICollectionView, g: String) {
        networkManager.getPictures(with: g) { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.imagesArray = data!
                collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func showPrevOriginImage(imagesArray: [ImagesResult], imageView: UIImageView, indexPath: inout Int) {
        indexPath -= 1
        if let urlWithString = imagesArray[indexPath].original {
            guard let url = URL(string: urlWithString) else { return }
            
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    imageView.image = image
                }
            }
            task.resume()
        }
    }
    
    func showNextOriginImage(imagesArray: [ImagesResult], imageView: UIImageView, indexPath: inout Int) {
        indexPath += 1
        if let urlWithString = imagesArray[indexPath].original {
            guard let url = URL(string: urlWithString) else { return }
            
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    imageView.image = image
                }
            }
            task.resume()
        }
    }

}
