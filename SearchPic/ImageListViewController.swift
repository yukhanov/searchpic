//
//  ViewController.swift
//  SearchPic
//
//  Created by Сергей Юханов on 06.02.2023.
//

import UIKit

class ImageListViewController: UIViewController, Coordinating {
    var coordinator: Coordinator?
    
    var viewModel: ListViewModel!

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        print("hello")
        viewModel = ListViewModel(networkManager: NetworkManager())
  
    }


}

