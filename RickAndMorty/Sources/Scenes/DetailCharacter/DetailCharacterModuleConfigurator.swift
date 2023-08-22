//
//  DetailCharacterModuleConfigurator.swift
//  RickAndMorty
//
//  Created by Vadim Kim on 19.08.2023.
//

import UIKit

final class DetailCharacterModuleConfigurator {

    func configure(router: MainRouterInput, with model: Character) -> DetailCharacterViewController {
        let view = DetailCharacterViewController()
        let presenter = DetailCharacterPresenter(
            view: view,
            router: router,
            networkService: NetworkService.shared,
            model: model
        )
        view.output = presenter
        return view
    }
}
