//
//  FeedMemesViewController.swift
//  Memes
//
//  Created by Алексей on 17.03.2024.
//

import UIKit

final class FeedMemesViewController: UICollectionViewController {

    private var memes: [Meme]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMem()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        memes?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemCell.reuseId, for: indexPath)
    
        guard let cell = cell as? MemCell else { return UICollectionViewCell() }
        
        let cellItem = memes?[indexPath.item]
        
        cell.configureCell(url: cellItem?.url ?? "")
        
        return cell
    }
}

// MARK: - Networking
extension FeedMemesViewController {
    private func fetchMem() {
        URLSession.shared.dataTask(
            with: URL(string: "https://api.imgflip.com/get_memes")!
        ) { [unowned self] data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let responseData = try JSONDecoder().decode(Mem.self, from: data)
                memes = responseData.data.memes
                memes?.shuffle()
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FeedMemesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        let widthCell = view.window?.windowScene?.screen.bounds.width ?? 0
        
        return CGSize(
            width: widthCell - 50,
            height: widthCell / 1.5
        )
    }
}
