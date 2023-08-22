//
//  CharacterInfoTraitView.swift
//  RickAndMorty
//
//  Created by Vadim Kim on 20.08.2023.
//

import UIKit

final class CharacterInfoTraitView: BaseView {

    // MARK: - Configuration

    func configure(with trait: String) {
        traitLabel.text = trait
    }

    // MARK: - Views

    private let titleLabel = UILabel()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        return stackView
    }()

    private lazy var traitLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Settings

    required init(title: String) {
        titleLabel.text = title
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupHierarchy() {
        addSubview(stackView)

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(traitLabel)
    }

    override func setupLayout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    override func setupView() {
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        titleLabel.textColor = Colors.lightGray.color

        traitLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        traitLabel.textColor = Colors.white.color
    }
}
