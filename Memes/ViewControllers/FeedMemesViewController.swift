//
//  FeedMemesViewController.swift
//  Memes
//
//  Created by Алексей on 17.03.2024.
//

import UIKit

final class FeedMemesViewController: UICollectionViewController {

    private let networkManager = NetworkManager.shared
    
    private var memes: [Meme] = []
    
    private let refresh = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMem()
        collectionView.addSubview(refresh)
        refresh.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
    }
    
    @objc private func refreshAction() {
        fetchMem()
    }
    
    private func fetchMem() {
        networkManager.fetchMem(from: Link.mem.url) { [unowned self] result in
            switch result {
            case .success(let success):
                memes = success.data.memes
                self.memes.shuffle()
                self.collectionView.reloadData()
                self.refresh.endRefreshing()
            case .failure(let error):
                print(error)
            }
        }
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

// MARK: - UICollectionViewDataSource
extension FeedMemesViewController {
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        memes.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MemCell.reuseId,
            for: indexPath
        )
        guard let cell = cell as? MemCell else { return UICollectionViewCell() }
        let cellItem = memes[indexPath.item]
        cell.configure(with: cellItem)
        return cell
    }
}
