//
//  NetworkManager.swift
//  SearchPic
//
//  Created by Сергей Юханов on 06.02.2023.
//

import Foundation

class NetworkManager {
    
   
    

    
    func getPictures(with g: String, completion: @escaping (Result<[ImagesResult]?,Error>)->Void) {
        let urlString = "https://serpapi.com/search.json?q=\(g)&tbm=isch&ijn=0&api_key=1369ea0742dc7627b35e82f39e2c82deec4a42c81ce9a7ce35dc4435c94a2748"
        guard  let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                    print(error.localizedDescription)
                }
               
            }
            guard let data = data  else {return}
            
            let decodedData = try? JSONDecoder().decode(Images.self, from: data)
            
            if let data = decodedData {
                DispatchQueue.main.async {
                    completion(.success(data.imagesResults))
                    
                }
            }
        }.resume()
    }
           
}
