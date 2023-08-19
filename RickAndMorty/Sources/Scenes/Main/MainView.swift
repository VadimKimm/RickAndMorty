//
//  MainView.swift
//  RickAndMorty
//
//  Created by Vadim Kim on 19.08.2023.
//

import UIKit

final class MainView: UIView {

    // MARK: - Views

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        return collectionView
    }()

    // MARK: - Settings

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        setupHierarchy()
        setupLayout()
        setupView()
    }

    // MARK: - Private functions

    private func setupHierarchy() {
        addSubview(collectionView)
    }

    private func setupLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setupView() {
        backgroundColor = Colors.darkBlue.color
        collectionView.backgroundColor = Colors.darkBlue.color
    }
}

// MARK: - Metrics

extension MainView {
    enum Metrics {
        static let navigationBarTopOffset: CGFloat = 55
        static let collectionViewTopOffset: CGFloat = 5
    }
}
