//
//  AsyncImageWrapper.swift
//  APITestingPOC
//
//  Created by Thiago Henrique on 31/08/22.
//

import Foundation
import UIKit

struct AsyncImageWrapper {
    static func load(url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url as URL) { (data, response, error) in
            completion(UIImage(data: data ?? Data()))
        }.resume()
    }
}
