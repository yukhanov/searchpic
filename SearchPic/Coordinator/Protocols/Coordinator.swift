//
//  Coordinator.swift
//  SearchPic
//
//  Created by Сергей Юханов on 06.02.2023.
//

import UIKit

enum Event {
    case loginButtonTapped
    case isUserAuthorised
    case logout
    case goToDetailVC(Data)
}

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    
    func eventOccured(with type: Event)
    func start()
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}


