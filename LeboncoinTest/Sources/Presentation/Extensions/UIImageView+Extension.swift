//
//  UIImageView+Extension.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 09/04/2022.
//

import UIKit

extension UIImageView {

    func urlImage(_ imageURL: String?) {
        self.image = UIImage(named: "placeholder")
        guard let imageURL = imageURL, let url = URL(string: imageURL) else { return }

        ImageRequestSession.shared.fetchImage(url: url) { (result: Result<UIImage, Error>) in
            switch result {
            case .success(let image):
                self.image = image
            case .failure:
                self.image = UIImage(named: "placeholder")
            }
        }
    }
}

private final class ImageRequestSession {

    // MARK: - Properties

    let imageCache = NSCache<NSString, UIImage>()

    static let shared = ImageRequestSession()
    private init() {}

    // MARK: - Methods

    func fetchImage(url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(.success(cachedImage))
        } else {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, _, _) in
                DispatchQueue.main.async {
                    if let data = data {
                        guard let image = UIImage(data: data) else {
                            return
                        }

                        self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                        completion(.success(image))
                    }
                }
            }).resume()
        }
    }
}
