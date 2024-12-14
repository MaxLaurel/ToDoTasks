//
//  URLtoImageFetcher.swift
//  ToDoTasks
//
//  Created by Максим on 28.11.2024.
//

import Foundation
import UIKit

protocol URLtoImageFetcherProtocol {
    func fetchImage(url: URL, completion: @escaping(Result<UIImage?, Error>) -> Void) -> URLSessionDataTask
}

class URLtoImageFetcher: URLtoImageFetcherProtocol {//это отдельный класс который занимается только запросами картинок из сети и их кешированием
    let config: URLSessionConfiguration
    let session: URLSession
    
    init() {
        self.config = URLSessionConfiguration.default
        self.session = URLSession(configuration: config)
        let cache = URLCache(memoryCapacity: 50 * 1024 * 1024, diskCapacity: 100 * 1024 * 1024, diskPath: "imageCache")
        config.urlCache = cache
        config.requestCachePolicy = .returnCacheDataElseLoad
        config.timeoutIntervalForRequest = 10
        config.waitsForConnectivity = true
    }
    
    //в этом методе мы проверяем есть ли закешированная картинка и если есть используем ее, а если нет то делаем запрос в сеть, при этом возвращаем URLSessionDataTask
    func fetchImage(url: URL, completion: @escaping(Result<UIImage?, Error>) -> Void) -> URLSessionDataTask{
        let request = URLRequest(url: url)
        
        //сначала проверяем есть ли загруженный кеш и возвращаем картинку
        if let cashedData = config.urlCache?.cachedResponse(for: request), let image = UIImage(data: cashedData.data) {
            completion(.success(image))
        }
        //если его нет соответственно делаем запрос в сеть
        let task = session.dataTask(with: request) { [weak self] data, response, error in
            if let error = error as? URLError {
                completion(.failure(error))
                return
            } else if let error = error {
                completion(.failure(error))
                return
            } else if let data = data, let response = response as? HTTPURLResponse, let image = UIImage(data: data) {
                let cashedData = CachedURLResponse(response: response, data: data)
                self?.config.urlCache?.storeCachedResponse(cashedData, for: request)
                completion(.success(image))
            } else {
                return
            }
        }
        task.resume()
        return task
    }
    
    //    func setImageWithGIFFromAsset(imageName: String, imageView: UIImageView) {
    //        // Загружаем GIF как данные из ассетов
    //        if let gifData = NSDataAsset(name: "SceletonNew")?.data {
    //            if let gifImage = UIImage.animatedImage(with: [UIImage(data: gifData)!], duration: 1.0) {
    //                imageView.image = gifImage
    //            }
    //        }
    //    }
}

