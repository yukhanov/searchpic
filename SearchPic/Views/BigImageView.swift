//
//  BigImageView.swift
//  SearchPic
//
//  Created by Сергей Юханов on 06.02.2023.
//

import UIKit

class BigImageView {
    func showBigPhoto(view: UIView, image: UIImage) {
        lazy var imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            return imageView
        }()
        
       lazy var bigImageView: UIView = {
            let view = UIView()
            view.addSubview(imageView)
            view.translatesAutoresizingMaskIntoConstraints = false
            
            return view
        }()
        
        view.addSubview(bigImageView)
        
        NSLayoutConstraint.activate([
            bigImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bigImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bigImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bigImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            imageView.leadingAnchor.constraint(equalTo: bigImageView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: bigImageView.topAnchor, constant: 100),
            imageView.trailingAnchor.constraint(equalTo: bigImageView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bigImageView.bottomAnchor)
        ])
    }
    
    func configure(with urlString: String) -> UIImage {
        var image: UIImage?
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async {
                    image = UIImage(data: data)
                    
                }
            }
            task.resume()
        }
        return image ?? UIImage.init(named: "q")!
    }
    

}
