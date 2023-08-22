//
//  DetailCharacterViewController.swift
//  RickAndMorty
//
//  Created by Vadim Kim on 19.08.2023.
//

import UIKit

protocol DetailCharacterViewInput: AnyObject {
    func update(with model: Character, episodes: [Episode])
}

final class DetailCharacterViewController: UIViewController {

    // MARK: - Properties

    var output: DetailCharacterViewOutput?
    
    private lazy var customView: DetailCharacterView = {
        let customView = DetailCharacterView()
        return customView
    }()

    // MARK: - Lifecycle

    override func loadView() {
        self.view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        output?.viewDidLoad()
    }

    deinit {
        print("💀" + "\(type(of: self)) " + "dead")
    }

    // MARK: - Private methods

    private func setupView() {
        let backItem = UIBarButtonItem()
        backItem.action = #selector(back)
        backItem.target = self
        backItem.image = Images.arrowLeft.systemImage?
            .withConfiguration(UIImage.SymbolConfiguration(weight: .medium))
            .withTintColor(.white, renderingMode: .alwaysOriginal)

        navigationItem.leftBarButtonItem = backItem
        navigationItem.largeTitleDisplayMode = .never
    }

    @objc private func back() {
        output?.back()
    }
}

// MARK: - DetailCharacterViewInput

extension DetailCharacterViewController: DetailCharacterViewInput {
    func update(with model: Character, episodes: [Episode]) {
        customView.stopActivity()
        customView.configure(with: model, episodes: episodes)
    }
}
