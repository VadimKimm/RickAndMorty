//
//  CharacterEpisodesView.swift
//  RickAndMorty
//
//  Created by Vadim Kim on 20.08.2023.
//

import UIKit

final class CharacterEpisodesView: BaseView {

    // MARK: - Configuration

    func configure(with episodes: [String]) {
        let pathComponents = episodes.map {
            let lastComponent = $0.components(separatedBy: "/").last
            return lastComponent ?? "1"
        }

        getEpisodes(episodes)
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

    // MARK: - Private functions

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
        titleLabel.text = Strings.episodes
    }

//    private func getEpisodes(_ episodes: [String]) {
//        episodes.forEach {
//            let request = NetworkRequest(endpoint: .episode, pathComponents: [$0])
//            NetworkService.shared.execute(request, expecting: Episode.self) { [weak self] result in
//                switch result {
//                case .success(let data):
//                    DispatchQueue.main.async {
//                        let episodeView = EpisodeView()
//                        episodeView.configure(with: data)
//                        self?.addToStackView(episodeView)
//                    }
//                case .failure(let error):
//                    print(error)
//                }
//            }
//        }
//    }

    private func getEpisodes(_ episodes: [String]) {
        episodes.forEach {
            guard let request = NetworkRequest(urlString: $0) else { return }
            NetworkService.shared.execute(request, expecting: Episode.self) { [weak self] result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        let episodeView = EpisodeView()
                        episodeView.configure(with: data)
                        self?.addToStackView(episodeView)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

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

    enum Strings {
        static let episodes = "Episodes"
    }
}
