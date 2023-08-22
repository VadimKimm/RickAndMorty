//
//  EpisodeView.swift
//  RickAndMorty
//
//  Created by Vadim Kim on 20.08.2023.
//

import UIKit

final class EpisodeView: BaseView {

    // MARK: - Configuration

    func configure(with episode: Episode) {
        titleLabel.text = episode.name
        airDateLabel.text = episode.airDate
        episodeLabel.text = getEpisodeName(from: episode.episode)
    }

    // MARK: - Views

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()

    private let episodeLabel = UILabel()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        return stackView
    }()

    private lazy var airDateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        return label
    }()

    // MARK: - Settings

    override func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(stackView)

        stackView.addArrangedSubview(episodeLabel)
        stackView.addArrangedSubview(airDateLabel)
    }

    override func setupLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: topAnchor,
                constant: Metrics.defaultOffset
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Metrics.defaultOffset
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -Metrics.defaultOffset
            )
        ])

        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: Metrics.defaultOffset
            ),
            stackView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Metrics.defaultOffset
            ),
            stackView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -Metrics.defaultOffset
            ),
            stackView.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -Metrics.defaultOffset
            )
        ])
    }

    override func setupView() {
        backgroundColor = Colors.gray.color
        layer.cornerRadius = Metrics.cornerRadius

        titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        titleLabel.textColor = Colors.white.color

        episodeLabel.font = .systemFont(ofSize: 13, weight: .medium)
        episodeLabel.textColor = Colors.green.color

        airDateLabel.font = .systemFont(ofSize: 12, weight: .medium)
        airDateLabel.textColor = Colors.lightGray.color
    }

    // MARK: - Configure episode name

    private func getEpisodeName(from string: String) -> String {
        let pattern = /S(?<season>[0-9]{2})E(?<episode>[0-9]{2})/

        guard let result = try? pattern.wholeMatch(in: string),
              let season = Int(result.season),
              let episode = Int(result.episode)
        else { return "" }

        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 1

        let formattedSeason = formatter.string(from: season as NSNumber) ?? ""
        let formattedEpisode = formatter.string(from: episode as NSNumber) ?? ""

        return "Episode: \(formattedEpisode), Season: \(formattedSeason)"
    }
}

// MARK: - Metrics

private extension EpisodeView {
    enum Metrics {
        static let cornerRadius: CGFloat = 16
        static let defaultOffset: CGFloat = 16
    }
}
