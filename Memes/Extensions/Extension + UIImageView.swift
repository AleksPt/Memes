//
//  Extension + UIImageView.swift
//  Memes
//
//  Created by Алексей on 17.03.2024.
//

import UIKit

extension UIImageView {
    func load(url: URL, _ activityIndicator: UIActivityIndicatorView) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        activityIndicator.stopAnimating()
                    }
                }
            }
        }
    }
}

