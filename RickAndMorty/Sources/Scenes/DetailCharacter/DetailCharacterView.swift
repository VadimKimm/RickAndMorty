//
//  DetailCharacterView.swift
//  RickAndMorty
//
//  Created by Vadim Kim on 19.08.2023.
//

import UIKit

final class DetailCharacterView: BaseView {

    // MARK: - Configuration

    func configure(with model: Character, episodes: [Episode]) {
        nameLabel.text = model.name
        statusLabel.text = model.status.rawValue.capitalized
        infoView.configure(with: model)
        originView.configure(with: model.origin.name)
        episodesView.configure(with: episodes)

        ImageLoaderService.shared.downloadImage(with: model.image) { [weak self] result in
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.5) { [weak self] in
                    guard let sself = self else { return }
                    switch result {
                    case .success(let data):
                        sself.imageView.image = UIImage(data: data)
                    case .failure:
                        sself.imageView.image = Images.noImageData.image
                    }
                }
            }
        }
    }

    // MARK: - Views

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        return indicator
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

    // MARK: - Settings

    override func setupHierarchy() {
        addSubview(scrollView)
        addSubview(activityIndicator)
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
                constant: Metrics.scrollViewDefaultOffset
            ),
            scrollView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -Metrics.scrollViewDefaultOffset
            ),
            scrollView.bottomAnchor.constraint(
                equalTo: bottomAnchor
            )
        ])

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
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
        scrollView.alpha = 0
        activityIndicator.startAnimating()

        imageView.layer.cornerRadius = Metrics.imageViewCornerRadius

        nameLabel.font = .systemFont(ofSize: 22, weight: .bold)
        nameLabel.textColor = Colors.white.color

        statusLabel.font = .systemFont(ofSize: 16, weight: .medium)
        statusLabel.textColor = Colors.green.color
    }
}

// MARK: - Stop activityIndicator

extension DetailCharacterView {
    func stopActivity() {
        self.activityIndicator.stopAnimating()

        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5) { [weak self] in
                self?.scrollView.alpha = 1
            }
        }
    }
}

// MARK: - Metrics

private extension DetailCharacterView {
    enum Metrics {
        static let cornerRadius: CGFloat = 16
        static let scrollViewTopOffset: CGFloat = 16
        static let scrollViewDefaultOffset: CGFloat = 24

        static let stackViewSpacing: CGFloat = 24
        static let stackViewCustomSpacing: CGFloat = 8

        static let imageViewCornerRadius: CGFloat = 16
        static let imageViewHeightMultiplier: CGFloat = 0.4
    }
}
