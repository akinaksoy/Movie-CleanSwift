//
//  CacheManager.swift
//  BeinSports
//
//  Created by Akın Aksoy on 29.03.2023.
//

import Foundation
import UIKit

class ImageManager {
    static let shared = ImageManager()

    private let cache = NSCache<NSString, UIImage>()

    func fetchImage(imageId: String, imageUrl: String, completion: @escaping (UIImage?) -> Void) {
        var imageView = UIImage()

        if let imageView = cache.object(forKey: imageId as NSString) {
            completion(imageView)
            return
        }

        guard let imageURL = URL.init(string: imageUrl) else {
            completion(nil)
            return
        }
        DispatchQueue.main.async {
            APIService.request(imageURL, method: .GET) { responseData in
                if let data = responseData.data, responseData.error == nil {
                    DispatchQueue.main.async {
                        guard let image = UIImage(data: data) else {return}
                        imageView = image
                        self.cache.setObject(imageView, forKey: imageId as NSString)
                        completion(imageView)
                    }
                } else {
                    completion(nil)
                }
            }
        }

    }

}
