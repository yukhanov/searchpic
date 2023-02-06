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
//    
//    func fetchImages(completion: @escaping(Result<[ImagesResult]?,Error>) -> Void) {
//        networkManager.getPictures { [weak self] (result) in
//            switch result {
//            case .success(let data):
//                if let data = data {
//                    self?.imagesArray = data
//                    completion(.success(data))
//                }
//            case .failure(let error):
//                completion(.failure(error))
//                
//            }
//        }
//    }
}
