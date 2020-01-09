//
//  URL+Extension.swift
//  Lastfm
//
//  Created by Consultant on 1/8/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

extension URL {
    
    func getImage(completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: self) { (dat, _, _) in
            if let data = dat {
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    completion(image)
                }
            }
        }.resume()
    }
}
