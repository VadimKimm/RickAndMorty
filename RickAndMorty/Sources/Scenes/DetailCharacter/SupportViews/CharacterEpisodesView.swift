//
//  CharacterEpisodesView.swift
//  RickAndMorty
//
//  Created by Vadim Kim on 20.08.2023.
//

import UIKit

final class CharacterEpisodesView: BaseView {

    // MARK: - Configuration

    func configure(with episodes: [Episode]) {
        episodes.forEach {
            let episodeView = EpisodeView()
            episodeView.configure(with: $0)
            self.addToStackView(episodeView)
        }
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

    // MARK: - Settings

    override func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(stackView)
    }

    override func setupLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])

        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: Metrics.stackViewOffset
            ),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    override func setupView() {
        titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        titleLabel.textColor = Colors.white.color
        titleLabel.text = String(localized: "detailCharacter.episodes")
    }

    // MARK: - Configure episode views

    private func addToStackView(_ view: UIView) {
        stackView.addArrangedSubview(view)

        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalTo: stackView.widthAnchor)
        ])
    }
}

// MARK: - Metrics

private extension CharacterEpisodesView {
    enum Metrics {
        static let stackViewOffset: CGFloat = 16
        static let stackViewSpacing: CGFloat = 16
    }
}
