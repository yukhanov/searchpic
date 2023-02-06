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
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        print("hello")

        listViewModel.fetchImages()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            print(self.listViewModel.imagesArray)
        }
    }


}

