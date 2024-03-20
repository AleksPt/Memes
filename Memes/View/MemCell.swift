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
    
    func configure(with mem: Meme) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: mem.url) else { return }
            DispatchQueue.main.async { [unowned self] in
                memImage.image = UIImage(data: imageData)
                activityIndicator.stopAnimating()
            }
        }
    }
}
