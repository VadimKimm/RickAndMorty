//
//  CharacterCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Vadim Kim on 19.08.2023.
//

import UIKit

final class CharacterCollectionViewCell: BaseCollectionViewCell {

    // MARK: - Configuration

    static func cellSize(collectionView: UICollectionView) -> CGSize {
        let width = (collectionView.frame.width - 63) / 2
        let height = width * 1.3
        return CGSize(width: width, height: height)
    }

    func configure(with model: Character) {
        nameLabel.text = model.name

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

    //MARK: - Properties

    static let identifier = String(describing: CharacterCollectionViewCell.self)

    // MARK: - Views

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Metrics.stackViewSpacing
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

    // MARK: - Settings

    override func setupHierarchy() {
        addSubview(stackView)

        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(nameLabel)
    }

    override func setupLayout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: Metrics.stackViewDefaultOffset
            ),
            stackView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Metrics.stackViewDefaultOffset
            ),
            stackView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -Metrics.stackViewDefaultOffset
            ),
            stackView.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -Metrics.stackViewBottomOffset
            )
        ])

        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: stackView.widthAnchor)
        ])
    }

    override func setupView() {
        backgroundColor = Colors.gray.color
        layer.cornerRadius = Metrics.cornerRadius

        imageView.layer.cornerRadius = Metrics.imageViewCornerRadius

        nameLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        nameLabel.textColor = Colors.white.color
    }


    override func prepareForReuse() {
        imageView.image = nil
        nameLabel.text = nil
    }
}

// MARK: - Metrics

private extension CharacterCollectionViewCell {
    enum Metrics {
        static let cornerRadius: CGFloat = 16

        static let stackViewSpacing: CGFloat = 16
        static let stackViewDefaultOffset: CGFloat = 8
        static let stackViewBottomOffset: CGFloat = 16

        static let imageViewCornerRadius: CGFloat = 10
    }
}
