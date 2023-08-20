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
    private var model: Character

    // MARK: - Internal methods

    init(view: DetailCharacterViewInput, router: MainRouterInput, model: Character) {
        self.view = view
        self.router = router
        self.model = model
    }

    func viewDidLoad() {
        view?.update(with: model)
    }

    func back() {
        router?.backToRootViewController()
    }
}
