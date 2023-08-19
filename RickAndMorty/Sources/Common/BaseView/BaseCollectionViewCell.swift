//
//  BaseCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Vadim Kim on 19.08.2023.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    // MARK: - Settings

    func commonInit() {
        setupHierarchy()
        setupLayout()
        setupView()
    }

    func setupHierarchy() {}

    func setupLayout() {}

    func setupView() {}
}
