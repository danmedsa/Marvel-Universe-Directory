//
//  File.swift
//  MarvelHeroDirectory
//
//  Created by Daniel Medina Sada on 10/3/21.
//

import UIKit

class CachingImageView: UIImageView {
    private var task: URLSessionDataTask?
    
    func setImage(thumbnail: Thumbnail) {
        task?.cancel()
        image = nil

        let path = thumbnail.imagePath
        if let image = CacheManager.loadCachedImage(from: path) {
            self.image = image
            return
        }
        
        guard let url = URL(string: path) else { return }
        let request = URLRequest(url: url)
        task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let self = self else { return }
            guard let data = data else {
                DispatchQueue.main.async {
                    self.image = UIImage(named: "image_not_available")
                }
                return
            }
            
            CacheManager.cacheImage(data, url: path)
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self.image = image
            }
        }
        
        task?.resume()
    }
}

