//
//  DetailCharacterView.swift
//  RickAndMorty
//
//  Created by Vadim Kim on 19.08.2023.
//

import UIKit

final class DetailCharacterView: BaseView {

    // MARK: - Configuration

    func configure(with model: Character) {
        nameLabel.text = model.name
        statusLabel.text = model.status.rawValue.capitalized
        infoView.configure(with: model)
        originView.configure(with: model.origin.name)
        episodesView.configure(with: model.episode)

        NetworkService.shared.downloadImage(with: model.image) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 0.5) { [weak self] in
                        self?.imageView.image = UIImage(data: data)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    // MARK: - Views

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Metrics.stackViewSpacing
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    private let infoView = CharacterInfoView()
    private let originView = CharacterOriginView()
    private let episodesView = CharacterEpisodesView()

    // MARK: - Private functions

    override func setupHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)

        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(statusLabel)
        stackView.addArrangedSubview(infoView)
        stackView.addArrangedSubview(originView)
        stackView.addArrangedSubview(episodesView)
    }

    override func setupLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: Metrics.scrollViewTopOffset
            ),
            scrollView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Metrics.scrollViewOffset
            ),
            scrollView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -Metrics.scrollViewOffset
            ),
            scrollView.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor
            )
        ])

        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        stackView.setCustomSpacing(Metrics.stackViewCustomSpacing, after: nameLabel)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(
                equalTo: stackView.widthAnchor,
                multiplier: Metrics.imageViewHeightMultiplier
            ),
            imageView.heightAnchor.constraint(
                equalTo: stackView.widthAnchor,
                multiplier: Metrics.imageViewHeightMultiplier
            )
        ])

        infoView.translatesAutoresizingMaskIntoConstraints = false
        originView.translatesAutoresizingMaskIntoConstraints = false
        episodesView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            originView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            episodesView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }

    override func setupView() {
        backgroundColor = Colors.darkBlue.color

        imageView.layer.cornerRadius = Metrics.imageViewCornerRadius

        nameLabel.font = .systemFont(ofSize: 22, weight: .bold)
        nameLabel.textColor = Colors.white.color

        statusLabel.font = .systemFont(ofSize: 16, weight: .medium)
        statusLabel.textColor = Colors.green.color
    }
}

// MARK: - Metrics

private extension DetailCharacterView {
    enum Metrics {
        static let cornerRadius: CGFloat = 16
        static let scrollViewTopOffset: CGFloat = 16
        static let scrollViewOffset: CGFloat = 24

        static let stackViewSpacing: CGFloat = 24
        static let stackViewCustomSpacing: CGFloat = 8

        static let imageViewCornerRadius: CGFloat = 16
        static let imageViewHeightMultiplier: CGFloat = 0.4
    }
}
