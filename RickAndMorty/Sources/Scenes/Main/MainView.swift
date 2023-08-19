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
            bottom: 0,
            right: Metrics.collectionViewRightInset
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

    // MARK: - Private functions

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
    }
}

// MARK: - Start/stop activityIndicator

extension MainView {
    func startActivity() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
            self.collectionView.alpha = 0
        }
    }

    func stopActivity() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
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
        static let collectionViewRightInset: CGFloat = 27
    }
}
