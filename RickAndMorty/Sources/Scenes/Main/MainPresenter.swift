//
//  MainPresenter.swift
//  RickAndMorty
//
//  Created by Vadim Kim on 19.08.2023.
//

import Foundation

protocol MainViewOutput: AnyObject {
    func fetchCharacters()
    func showDetail(for model: Character)
}

final class MainPresenter: MainViewOutput {

    // MARK: - Properties

    private weak var view: MainViewInput?
    private var router: MainRouterInput?
    private var networkService: NetworkServiceType?

    // MARK: - Internal methods

    init(view: MainViewInput, router: MainRouterInput, networkService: NetworkServiceType) {
        self.view = view
        self.router = router
        self.networkService = networkService
    }

    func fetchCharacters() {
        networkService?.execute(
            .listCharacters,
            expecting: AllCharactersResponse.self
        ) { [weak self] result in
            switch result {
            case .success(let model):
                self?.view?.reload(with: model.results)
            case .failure(let error):
                print(error)
            }
        }
    }

    func showDetail(for model: Character) {
        router?.showDetailScreen(with: model)
    }
}
