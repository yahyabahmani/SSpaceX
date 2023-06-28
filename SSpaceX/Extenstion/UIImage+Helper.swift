//
//  UIImage+Helper.swift
//  SSpaceX
//
//  Created by Jabama on 6/28/23.
//

import Foundation
import UIKit
extension UIImageView {
    private static let imageCache = NSCache<NSString, UIImage>()

    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        if let cachedImage = UIImageView.imageCache.object(forKey: url.absoluteString as NSString) {
            self.image = cachedImage
        } else {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error loading image: \(error.localizedDescription)")
                    return
                }
                guard let data = data, let image = UIImage(data: data) else {
                    print("Invalid image data")
                    return
                }
                UIImageView.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                DispatchQueue.main.async {
                    self.image = image
                }
            }.resume()
        }
    }
}
