//
//  ViewController.swift
//  SearchPic
//
//  Created by Сергей Юханов on 06.02.2023.
//

import UIKit

class ImageListViewController: UIViewController, Coordinating {
    var coordinator: Coordinator?
    let networkService = NetworkManager()
    var listViewModel = ListViewModel()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        print("hello")
        networkService.getPictures { result in
            switch result {
            case .success(let data):
                self.listViewModel.imagesArray = data!
            case .failure(let error):
                print(error)
            }
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            print(self.listViewModel.imagesArray)
        }
    }


}

