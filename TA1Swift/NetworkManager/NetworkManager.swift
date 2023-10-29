//
//  NetworkManager.swift
//  TA1Swift
//
//  Created by Сергей Иванчихин on 29.10.2023.
//

import Foundation
import UIKit

protocol ImageDownloadable {
    func downloadImage(from url: NSURL, completion: @escaping (UIImage?) -> Void)
}

class NetworkManager: ImageDownloadable {
    static let shared = NetworkManager()
    
    private init() {}
    
    func downloadImage(
        from url: NSURL,
        completion: @escaping (UIImage?) -> Void
    ) {
        let task = URLSession
            .shared
            .dataTask(with: url as URL) { data, response, error in
            guard error == nil, let data = data, let image = UIImage(data: data) 
                else {
                completion(nil)
                return
            }
            completion(image)
        }
        task.resume()
    }
    
}
