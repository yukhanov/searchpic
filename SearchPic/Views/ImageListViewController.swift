//
//  ViewController.swift
//  SearchPic
//
//  Created by Сергей Юханов on 06.02.2023.
//

import UIKit
import WebKit

class ImageListViewController: UIViewController, Coordinating {
    var coordinator: Coordinator?
    var listViewModel = ListViewModel()
    
    var sourceByIndexPath: String?
    var currentIndexPath = Int()
    
    private var collectionView: UICollectionView?
    private var searchBar = UISearchBar()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
   private lazy var bigImageView: UIView = {
        let view = UIView()
       view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    private lazy var linkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
       
        button.setTitle("Go to source", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    private lazy var prevButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
       
        button.setTitle("Prev", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
       
        button.setTitle("Next", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Search images"
        leftBarButton()
        setViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchBar.frame = CGRect(x: 20, y: view.safeAreaInsets.top, width: view.frame.size.width-20, height: 50)
        collectionView?.frame = CGRect(x: 0, y: view.safeAreaInsets.top+55, width: view.frame.size.width, height: view.frame.size.height-55)
    }
    
    func leftBarButton() {
        let leftBarButton = UIBarButtonItem(title: "Back",
                                            style: UIBarButtonItem.Style.done,
                                            target: self,
                                            action: #selector(goToList))
        
        navigationItem.leftBarButtonItem = leftBarButton

    }
    
    @objc func goToList() {
        //coordinator?.eventOccured(with: .goToListVC)
        bigImageView.removeFromSuperview()
        webView.removeFromSuperview()
        
    }
    
    @objc func showPrevImage() {
        listViewModel.showPrevOriginImage(imagesArray: listViewModel.imagesArray, imageView: imageView, indexPath: &currentIndexPath)
    }
    
    @objc func showNextImage() {
        listViewModel.showNextOriginImage(imagesArray: listViewModel.imagesArray, imageView: imageView, indexPath: &currentIndexPath)
    }
    
    func showBigImage() {
  
        
        view.addSubview(bigImageView)
        bigImageView.addSubview(imageView)
        bigImageView.addSubview(linkButton)
        bigImageView.addSubview(prevButton)
        bigImageView.addSubview(nextButton)
        setConstraintsForButtons()
        linkButton.addTarget(self, action: #selector(openSource), for: .touchUpInside)
        prevButton.addTarget(self, action: #selector(showPrevImage), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(showNextImage), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            bigImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bigImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bigImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bigImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            imageView.leadingAnchor.constraint(equalTo: bigImageView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: bigImageView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: bigImageView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bigImageView.bottomAnchor)
        ])
    }
    
    func configure(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self?.imageView.image = image
            }
        }
        task.resume()
    }
    

    

    
    @objc func openSource() {
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        loadRequest()
    }
    
    func loadRequest() {
        guard let url = URL(string: sourceByIndexPath!) else { return }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }

}

extension ImageListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        listViewModel.imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
 
        currentIndexPath = indexPath.row
        if let urlToBigImage = listViewModel.imagesArray[indexPath.row].original {
    
            sourceByIndexPath = listViewModel.imagesArray[indexPath.row].link
            configure(with: urlToBigImage)
            showBigImage()
            
            
        }
       
    
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
        collectionView.delegate = self
        searchBar.delegate = self
        view.addSubview(collectionView)
        view.addSubview(searchBar)
        self.collectionView = collectionView
    }
    
    func setConstraintsForButtons() {
        NSLayoutConstraint.activate([
            linkButton.leadingAnchor.constraint(equalTo: bigImageView.leadingAnchor, constant: 20),
            linkButton.topAnchor.constraint(equalTo: bigImageView.topAnchor, constant: 20),
            
            prevButton.leadingAnchor.constraint(equalTo: bigImageView.leadingAnchor, constant: 20),
            prevButton.bottomAnchor.constraint(equalTo: bigImageView.bottomAnchor, constant: -50),
            
            nextButton.trailingAnchor.constraint(equalTo: bigImageView.trailingAnchor, constant: -20),
            nextButton.bottomAnchor.constraint(equalTo: bigImageView.bottomAnchor, constant: -50)
        ])
    }
    

}

