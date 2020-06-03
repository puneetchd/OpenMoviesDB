//
//  GlobalExtensions.swift
//  OpenMoviesDB
//
//  Created by Puneet Sharma on 6/3/20.
//  Copyright © 2020 Puneet Sharma. All rights reserved.
//

import Foundation
import UIKit.UIImageView

typealias CallbackHandler = (_ callbackType: Callback) -> Void
typealias NetworkAPIHandler = (_ data: Data?, _ error: NetworkError?) -> Void
typealias MoviesSearchSuccessCompletionHandler = (_ moviesList: DataMoviesModel?) -> Void
typealias MoviesDetailsSuccessCompletionHandler = (_ moviesList: DataMovieDetailsModel?) -> Void
typealias MoviesRequestErrorHandler = (_ error: NetworkError?) -> Void

enum NetworkRequestType: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

enum Callback {
    case showLoader
    case hideLoader
    case reloadContent
    case showError(error: NetworkError)
}

extension URLSession {
    func dataTask(with urlRequest: URLRequest, result: @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTask {
        return dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                result(.failure(error))
                return
            }
            guard let response = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            result(.success((response, data)))
        }
    }
}

extension UIImageView {
    func loadImageUsingCache(withUrl urlString: String) {
        let imageCache = NSCache<NSString, UIImage>()
        let url = URL(string: urlString)
        if url == nil { return }
        self.image = nil

        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }

        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.medium)
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.center = self.center

        URLSession.shared.dataTask(
            with: url!,
            completionHandler: { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                DispatchQueue.main.async {
                    if let image = UIImage(data: data!) {
                        imageCache.setObject(image, forKey: urlString as NSString)
                        self.image = image
                        activityIndicator.removeFromSuperview()
                    }
                }
            }
        ).resume()
    }
}

extension UICollectionView {
    func scrollToTop() {
        let indexPath = IndexPath(row: 0, section: 0)
        if self.hasRowAtIndexPath(indexPath: indexPath) {
            self.scrollToItem(at: indexPath, at: .top, animated: true)
        }
    }

    func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
        return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfItems(inSection: indexPath.section)
    }
}
