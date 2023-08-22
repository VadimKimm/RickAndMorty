//
//  DetailCharacterPresenter.swift
//  RickAndMorty
//
//  Created by Vadim Kim on 19.08.2023.
//

import Foundation

protocol DetailCharacterViewOutput: AnyObject {
    func viewDidLoad()
    func back()
}

final class DetailCharacterPresenter: DetailCharacterViewOutput {

    // MARK: - Properties

    private weak var view: DetailCharacterViewInput?
    private var router: MainRouterInput?
    private var networkService: NetworkServiceType?
    private var model: Character

    // MARK: - Internal methods

    init(
        view: DetailCharacterViewInput,
        router: MainRouterInput,
        networkService: NetworkServiceType,
        model: Character
    ) {
        self.view = view
        self.router = router
        self.networkService = networkService
        self.model = model
    }

    func viewDidLoad() {
        let group = DispatchGroup()
        var episodes: [Episode] = []

        model.episode.forEach {
            guard let request = NetworkRequest(urlString: $0) else {
                showAlert(with: NetworkError.failedToCreateRequest.localizedDescription)
                return
            }
            group.enter()

            NetworkService.shared.execute(request, expecting: Episode.self) { [weak self] result in
                switch result {
                case .success(let model):
                    episodes.append(model)
                case .failure(let error):
                    self?.showAlert(with: error.localizedDescription)
                    print(error)
                }
                group.leave()
            }
        }

        group.notify(queue: DispatchQueue.main) { [weak self] in
            guard let sself = self else { return }
            sself.view?.update(with: sself.model, episodes: episodes)
        }
    }

    func back() {
        router?.backToRootViewController()
    }

    // MARK: - Private methods

    private func showAlert(with message: String) {
        DispatchQueue.main.async {
            self.router?.showAlert(with: String(describing: message))
        }
    }
}
