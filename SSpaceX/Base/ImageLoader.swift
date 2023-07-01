//
//  ImageLoader.swift
//  SSpaceX
//
//  Created by yahya on 6/28/23.
//

import Foundation
import UIKit

class ImageLoader {
    private static let cache = NSCache<NSString, UIImage>()

    static func loadImage(with urlString: String, completion: @escaping (UIImage?) -> Void) {
        // Check if the image is already cached
        if let cachedImage = cache.object(forKey: urlString as NSString) {
            completion(cachedImage)
            return
        }

        // If the image is not cached, download it from the URL
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode),
                  let data = data,
                  let image = UIImage(data: data) else {
                completion(nil)
                return
            }

            // Cache the downloaded image
            cache.setObject(image, forKey: urlString as NSString)

            completion(image)
        }

        task.resume()
    }
}

