//
//  MainPresenter.swift
//  RickAndMorty
//
//  Created by Vadim Kim on 19.08.2023.
//

import Foundation

protocol MainViewOutput: AnyObject {
    func fetchInitialData()
    func fetchMoreData()
    func showDetail(for model: Character)
}

final class MainPresenter: MainViewOutput {

    // MARK: - Properties

    private weak var view: MainViewInput?
    private var router: MainRouterInput?
    private var networkService: NetworkServiceType?
    private var charactersResponse: AllCharactersResponse?

    // MARK: - Internal methods

    init(view: MainViewInput, router: MainRouterInput, networkService: NetworkServiceType) {
        self.view = view
        self.router = router
        self.networkService = networkService
    }

    func fetchInitialData() {
        networkService?.execute(.listCharacters, expecting: AllCharactersResponse.self) { [weak self] result in
            switch result {
            case .success(let response):
                self?.charactersResponse = response
                self?.reload()
            case .failure(let error):
                self?.showAlert(with: error.localizedDescription)
                print(error)
            }
        }
    }

    func fetchMoreData() {
        guard let urlString = charactersResponse?.info.next,
              let request = NetworkRequest(urlString: urlString)
        else { return }

        networkService?.execute(request, expecting: AllCharactersResponse.self) { [weak self] result in
            switch result {
            case .success(let response):
                self?.charactersResponse?.results.append(contentsOf: response.results)
                self?.charactersResponse?.info = response.info
                self?.reloadWithNewData()
            case .failure(let error):
                self?.showAlert(with: error.localizedDescription)
                print(error)
            }
        }
    }

    func showDetail(for model: Character) {
        router?.showDetailScreen(with: model)
    }

    // MARK: - Private methods

    private func reload() {
        guard let charactersResponse = charactersResponse else { return }
        DispatchQueue.main.async {
            self.view?.didFetchInitialData(with: charactersResponse)
        }
    }

    private func reloadWithNewData() {
        guard let charactersResponse = charactersResponse else { return }
        DispatchQueue.main.async {
            self.view?.didFetchMoreData(with: charactersResponse)
        }
    }

    private func showAlert(with message: String) {
        DispatchQueue.main.async {
            self.router?.showAlert(with: String(describing: message))
        }
    }
}
