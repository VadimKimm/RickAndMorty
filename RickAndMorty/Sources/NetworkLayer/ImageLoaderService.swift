//
//  ImageLoaderService.swift
//  RickAndMorty
//
//  Created by Vadim Kim on 22.08.2023.
//

import Foundation

final class ImageLoaderService {

    // MARK: - Properties

    static let shared = ImageLoaderService()
    private var imageCache = NSCache<NSString, NSData>()

    // MARK: - Initialization

    private init() {}

    // MARK: - Internal methods

    func downloadImage(
        with urlString: String,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        if let data = imageCache.object(forKey: urlString as NSString) {
            completion(.success(data as Data))
            return
        }

        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.badUrl))
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NetworkError.failedToGetData))
                return
            }

            self?.imageCache.setObject(data as NSData, forKey: urlString as NSString)
            completion(.success(data))
        }
        task.resume()
    }
}
