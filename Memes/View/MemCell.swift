//
//  MemCell.swift
//  Memes
//
//  Created by Алексей on 17.03.2024.
//

import UIKit

final class MemCell: UICollectionViewCell {

    static let reuseId = "MemCell"
    
    @IBOutlet weak var memImage: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        memImage.contentMode = .scaleAspectFill
        memImage.layer.cornerRadius = 15
        memImage.clipsToBounds = true
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
    override func prepareForReuse() {
        memImage.image = nil
    }
    
    func configureCell(url: String) {
        guard let url = URL(string: url) else {
            memImage.image = .noimg
            return
        }
        memImage.load(url: url, activityIndicator)
    }
}
