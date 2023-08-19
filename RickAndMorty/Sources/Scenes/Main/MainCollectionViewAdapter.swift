//
//  MainCollectionViewAdapter.swift
//  RickAndMorty
//
//  Created by Vadim Kim on 19.08.2023.
//

import UIKit

final class MainCollectionViewAdapter: NSObject {

    // MARK: - Properties

    private var collectionView: UICollectionView
    private var dataSource: [Character] = []

    // MARK: - Initialization

    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        setupCollection()
    }

    // MARK: - Configuration

    func configure(with dataSource: [Character]) {
        self.dataSource = dataSource
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    // MARK: - Private methods

    private func setupCollection() {
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(
            CharacterCollectionViewCell.self,
            forCellWithReuseIdentifier: CharacterCollectionViewCell.identifier
        )
    }

    private func downloadImage(
        with urlString: String,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.badUrl))
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NetworkError.failedToGetData))
                return
            }

            completion(.success(data))
        }
        task.resume()
    }
}

// MARK: - UICollectionViewDataSource

extension MainCollectionViewAdapter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CharacterCollectionViewCell.identifier,
            for: indexPath
        ) as? CharacterCollectionViewCell else { return UICollectionViewCell() }
        let model = dataSource[indexPath.row]
        cell.configure(with: model.name)
        downloadImage(with: model.image) { result in
            switch result {
            case .success(let data):
                cell.setImage(data)
            case .failure(let error):
                print(error)
            }
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension MainCollectionViewAdapter: UICollectionViewDelegate {}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainCollectionViewAdapter: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CharacterCollectionViewCell.cellSize(collectionView: collectionView)
    }
}
