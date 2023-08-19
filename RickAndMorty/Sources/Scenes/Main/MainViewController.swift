//
//  MainViewController.swift
//  RickAndMorty
//
//  Created by Vadim Kim on 19.08.2023.
//

import UIKit

protocol MainViewInput: AnyObject {
    func reload(with datasource: [Character])
}

final class MainViewController: UIViewController {

    // MARK: - Properties

    var output: MainViewOutput?
    var adapter: MainCollectionViewAdapter?

    private lazy var customView: MainView = {
        let customView = MainView()
        return customView
    }()

    // MARK: - Lifecycle

    override func loadView() {
        self.view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionViewAdapter()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCharacters()
    }

    // MARK: - Private functions

    private func setupView() {
        title = "Characters"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupCollectionViewAdapter() {
        adapter = MainCollectionViewAdapter(collectionView: customView.collectionView)
    }

    private func fetchCharacters() {
        customView.startActivity()
        output?.fetchCharacters()
    }
}

// MARK: - MainViewInput

extension MainViewController: MainViewInput {
    func reload(with datasource: [Character]) {
        adapter?.configure(with: datasource)
        customView.stopActivity()
    }
}
