//
//  ActivityFooterReusableView.swift
//  RickAndMorty
//
//  Created by Vadim Kim on 21.08.2023.
//

import UIKit

final class ActivityFooterReusableView: UICollectionReusableView {

    // MARK: - Configuration

    static func footerSize(collectionView: UICollectionView) -> CGSize {
        CGSize(
            width: collectionView.frame.width,
            height: 50
        )
    }
    //MARK: - Properties

    static let identifier = String(describing: ActivityFooterReusableView.self)

    // MARK: - Views

    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        return indicator
    }()

    // MARK: - Settings

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        setupHierarchy()
        setupLayout()
        setupView()
    }

    // MARK: - Private methods

    private func setupHierarchy() {
        addSubview(activityIndicator)
    }

    private func setupLayout() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    private func setupView() {
        activityIndicator.startAnimating()
    }
}
