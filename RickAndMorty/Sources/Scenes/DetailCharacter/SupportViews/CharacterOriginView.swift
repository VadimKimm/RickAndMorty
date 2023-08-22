//
//  CharacterOriginView.swift
//  RickAndMorty
//
//  Created by Vadim Kim on 20.08.2023.
//

import UIKit

final class CharacterOriginView: BaseView {

    // MARK: - Configuration

    func configure(with text: String) {
        planetNameLabel.text = text.capitalized
    }

    // MARK: - Views

    private let titleLabel = UILabel()

    private lazy var containerImageView = UIView()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: Strings.planetIcon)
        return imageView
    }()

    private let containerPlanetView = UIView()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Metrics.stackViewSpacing
        stackView.alignment = .leading
        return stackView
    }()

    private lazy var planetNameLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 0
        return label
    }()

    private let planetLabel = UILabel()

    // MARK: - Private functions

    override func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(containerPlanetView)

        containerPlanetView.addSubview(containerImageView)
        containerImageView.addSubview(imageView)
        containerPlanetView.addSubview(stackView)

        stackView.addArrangedSubview(planetNameLabel)
        stackView.addArrangedSubview(planetLabel)
    }

    override func setupLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        containerPlanetView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerPlanetView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: Metrics.containerViewTopOffset
            ),
            containerPlanetView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerPlanetView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerPlanetView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        containerImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerImageView.centerYAnchor.constraint(equalTo: containerPlanetView.centerYAnchor),
            containerImageView.topAnchor.constraint(
                equalTo: containerPlanetView.topAnchor,
                constant: Metrics.containerImageViewOffset
            ),
            containerImageView.leadingAnchor.constraint(
                equalTo: containerPlanetView.leadingAnchor,
                constant: Metrics.containerImageViewOffset
            ),
            containerImageView.bottomAnchor.constraint(
                equalTo: containerPlanetView.bottomAnchor,
                constant: -Metrics.containerImageViewOffset
            ),
            containerImageView.heightAnchor.constraint(
                equalTo: containerPlanetView.heightAnchor,
                constant: -Metrics.containerImageViewHeightOffset
            ),
            containerImageView.widthAnchor.constraint(
                equalTo: containerPlanetView.heightAnchor,
                constant: -Metrics.containerImageViewHeightOffset
            )
        ])

        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: containerImageView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: containerImageView.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: Metrics.imageViewHeight),
            imageView.widthAnchor.constraint(equalToConstant: Metrics.imageViewHeight)
        ])

        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo: containerPlanetView.topAnchor,
                constant: Metrics.stackViewOffset
            ),
            stackView.leadingAnchor.constraint(
                equalTo: containerImageView.trailingAnchor,
                constant: Metrics.stackViewOffset
            ),
            stackView.trailingAnchor.constraint(
                equalTo: containerPlanetView.trailingAnchor,
                constant: -Metrics.stackViewOffset
            ),
            stackView.bottomAnchor.constraint(
                equalTo: containerPlanetView.bottomAnchor,
                constant: -Metrics.stackViewOffset
            )
        ])
    }

    override func setupView() {
        containerPlanetView.backgroundColor = Colors.gray.color
        containerPlanetView.layer.cornerRadius = Metrics.containerPlanetViewCornerRadius

        containerImageView.backgroundColor = Colors.darkBlue.color
        containerImageView.layer.cornerRadius = Metrics.containerImageViewCornerRadius

        titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        titleLabel.textColor = Colors.white.color
        titleLabel.text = Strings.origin

        planetNameLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        planetNameLabel.textColor = Colors.white.color

        planetLabel.font = .systemFont(ofSize: 13, weight: .medium)
        planetLabel.textColor = Colors.green.color
        planetLabel.text = Strings.planet
    }
}

// MARK: - Metrics

private extension CharacterOriginView {
    enum Metrics {
        static let containerViewTopOffset: CGFloat = 16
        static let containerPlanetViewCornerRadius: CGFloat = 16

        static let containerImageViewHeightOffset: CGFloat = 16
        static let containerImageViewCornerRadius: CGFloat = 10

        static let imageViewHeight: CGFloat = 24

        static let containerImageViewOffset: CGFloat = 8
        
        static let stackViewSpacing: CGFloat = 8
        static let stackViewOffset: CGFloat = 16
    }

    enum Strings {
        static let origin = "Origin"
        static let planet = "Planet"
        static let planetIcon = "planetIcon"
    }
}
