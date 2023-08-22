//
//  MainView.swift
//  RickAndMorty
//
//  Created by Vadim Kim on 19.08.2023.
//

import UIKit

final class MainView: BaseView {

    // MARK: - Views

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(
            top: Metrics.collectionViewSectionTopInset,
            left: Metrics.collectionViewSectionLeftInset,
            bottom: Metrics.collectionViewSectionBottomInset,
            right: Metrics.collectionViewSectionRightInset
        )
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        return collectionView
    }()

    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        return indicator
    }()

    // MARK: - Settings

    override func setupHierarchy() {
        addSubview(collectionView)
        addSubview(activityIndicator)
    }

    override func setupLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    override func setupView() {
        backgroundColor = Colors.darkBlue.color

        collectionView.backgroundColor = Colors.darkBlue.color
        collectionView.alpha = 0

        activityIndicator.startAnimating()
    }
}

// MARK: - Stop activityIndicator

extension MainView {
    func stopActivity() {
        self.activityIndicator.stopAnimating()
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5) { [weak self] in
                self?.collectionView.alpha = 1
            }
        }
    }
}

// MARK: - Metrics

extension MainView {
    enum Metrics {
        static let collectionViewSectionTopInset: CGFloat = 31
        static let collectionViewSectionLeftInset: CGFloat = 20
        static let collectionViewSectionRightInset: CGFloat = 27
        static let collectionViewSectionBottomInset: CGFloat = 0
    }
}
