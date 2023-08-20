//
//  CharacterInfoView.swift
//  RickAndMorty
//
//  Created by Vadim Kim on 19.08.2023.
//

import UIKit

final class CharacterInfoView: BaseView {

    // MARK: - Configuration

    func configure(with model: Character) {
        speciesView.configure(with: model.species)
        typeView.configure(with: model.type.isEmpty ? "None": model.type)
        genderView.configure(with: model.gender.rawValue)
    }

    // MARK: - Views

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Metrics.stackViewSpacing
        stackView.alignment = .fill
        return stackView
    }()

    private let titleLabel = UILabel()
    private let containerView = UIView()
    private let speciesView = CharacterInfoTraitView(title: Strings.species)
    private let typeView = CharacterInfoTraitView(title: Strings.type)
    private let genderView = CharacterInfoTraitView(title: Strings.gender)

    // MARK: - Private functions

    override func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(containerView)

        containerView.addSubview(stackView)
        stackView.addArrangedSubview(speciesView)
        stackView.addArrangedSubview(typeView)
        stackView.addArrangedSubview(genderView)
    }

    override func setupLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])

        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: Metrics.containerViewTopOffset
            ),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo: containerView.topAnchor,
                constant: Metrics.stackViewOffset
            ),
            stackView.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor,
                constant: Metrics.stackViewOffset
            ),
            stackView.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor,
                constant: -Metrics.stackViewOffset
            ),
            stackView.bottomAnchor.constraint(
                equalTo: containerView.bottomAnchor,
                constant: -Metrics.stackViewOffset
            )
        ])

        speciesView.translatesAutoresizingMaskIntoConstraints = false
        typeView.translatesAutoresizingMaskIntoConstraints = false
        genderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            speciesView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            typeView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            genderView.widthAnchor.constraint(equalTo: stackView.widthAnchor)
        ])
    }

    override func setupView() {
        containerView.backgroundColor = Colors.gray.color
        containerView.layer.cornerRadius = Metrics.containerViewCornerRadius

        titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        titleLabel.textColor = Colors.white.color
        titleLabel.text = Strings.info
    }
}

// MARK: - Metrics

private extension CharacterInfoView {
    enum Metrics {
        static let stackViewOffset: CGFloat = 16
        static let stackViewSpacing: CGFloat = 16

        static let containerViewTopOffset: CGFloat = 16
        static let containerViewCornerRadius: CGFloat = 16
    }

    enum Strings {
        static let info = "Info"
        static let species = "Species:"
        static let type = "Type:"
        static let gender = "Gender:"
    }
}
