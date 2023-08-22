//
//  MainViewController.swift
//  RickAndMorty
//
//  Created by Vadim Kim on 19.08.2023.
//

import UIKit

protocol MainViewInput: AnyObject {
    func didFetchInitialData(with charactersResponse: AllCharactersResponse)
    func didFtechMoreData(with charactersResponse: AllCharactersResponse)
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
        fetchInitialData()
    }

    // MARK: - Private functions

    private func setupView() {
        title = "Characters"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupCollectionViewAdapter() {
        adapter = MainCollectionViewAdapter(
            collectionView: customView.collectionView,
            output: self
        )
    }

    private func fetchInitialData() {
        customView.startActivity()
        output?.fetchInitialData()
    }
}

// MARK: - MainViewInput

extension MainViewController: MainViewInput {
    func didFetchInitialData(with charactersResponse: AllCharactersResponse) {
        adapter?.configure(with: charactersResponse)
        customView.stopActivity()
    }

    func didFtechMoreData(with charactersResponse: AllCharactersResponse) {
        adapter?.update(with: charactersResponse)
    }
}

// MARK: - MainCollectionViewAdapterOutput

extension MainViewController: MainCollectionViewAdapterOutput {
    func didSelectCell(with model: Character) {
        output?.showDetail(for: model)
    }

    func fetchMoreData() {
        output?.fetchMoreData()
    }
}
