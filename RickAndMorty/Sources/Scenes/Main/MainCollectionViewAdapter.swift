//
//  MainCollectionViewAdapter.swift
//  RickAndMorty
//
//  Created by Vadim Kim on 19.08.2023.
//

import UIKit

protocol MainCollectionViewAdapterOutput: AnyObject {
    func didSelectCell(with model: Character)
    func fetchMoreData()
}

final class MainCollectionViewAdapter: NSObject {

    // MARK: - Properties

    private let output: MainCollectionViewAdapterOutput
    private let collectionView: UICollectionView
    private var dataSource: [Character] = []
    private var apiInfo: Info?

    private var shouldLoadMoreData: Bool { apiInfo?.next != nil }
    private var isFetching = false

    // MARK: - Initialization

    init(collectionView: UICollectionView, output: MainCollectionViewAdapterOutput) {
        self.collectionView = collectionView
        self.output = output
        super.init()
        setupCollection()
    }

    // MARK: - Configuration

    func configure(with charactersResponse: AllCharactersResponse) {
        self.dataSource = charactersResponse.results
        self.apiInfo = charactersResponse.info
        isFetching = false

        self.collectionView.reloadData()
    }

    func update(with charactersResponse: AllCharactersResponse) {
        let oldDataCount = self.dataSource.count
        let newDataCount = charactersResponse.results.count
        let indexPaths: [IndexPath] = Array(oldDataCount..<newDataCount).compactMap { IndexPath(row: $0, section: 0) }

        self.dataSource = charactersResponse.results
        self.apiInfo = charactersResponse.info
        isFetching = false

        self.collectionView.performBatchUpdates { [weak self] in
            self?.collectionView.insertItems(at: indexPaths)
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
        collectionView.register(
            ActivityFooterReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: ActivityFooterReusableView.identifier
        )
    }
}

// MARK: - UICollectionViewDataSource

extension MainCollectionViewAdapter: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        dataSource.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CharacterCollectionViewCell.identifier,
            for: indexPath
        ) as? CharacterCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: dataSource[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension MainCollectionViewAdapter: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        output.didSelectCell(with: dataSource[indexPath.row])
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainCollectionViewAdapter: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CharacterCollectionViewCell.cellSize(collectionView: collectionView)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForFooterInSection section: Int
    ) -> CGSize {
        if shouldLoadMoreData {
            return ActivityFooterReusableView.footerSize(collectionView: collectionView)
        } else {
            return .zero
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
              let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionFooter,
                withReuseIdentifier: ActivityFooterReusableView.identifier,
                for: indexPath
              ) as? ActivityFooterReusableView else { return UICollectionReusableView() }

        return footer
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldLoadMoreData, !isFetching else { return }

        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] timer in
            guard let sself = self else { return }

            let contentOffset = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            let scrollViewHeight = scrollView.frame.size.height
            let offset: CGFloat = 60

            if contentOffset >= (contentHeight - scrollViewHeight - offset) {
                guard !sself.isFetching else { return }
                sself.isFetching = true
                sself.output.fetchMoreData()
            }
            timer.invalidate()
        }
    }
}
