//
//  ListViewModel.swift
//  SearchPic
//
//  Created by Сергей Юханов on 06.02.2023.
//

import Foundation

class ListViewModel {
    let networkManager: NetworkManager!
    var imagesArray = [ImagesResult]()
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchImages(completion: @escaping(Result<[ImagesResult]?,Error>) -> Void) {
        networkManager.getPictures { [weak self] (result) in
            switch result {
            case .success(let data):
                if let data = data {
                    self?.imagesArray = data
                    completion(.success(data))
                }
            case .failure(let error):
                completion(.failure(error))
                
            }
        }
    }
}
