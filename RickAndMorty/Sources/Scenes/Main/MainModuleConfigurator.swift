//
//  MainModuleConfigurator.swift
//  RickAndMorty
//
//  Created by Vadim Kim on 19.08.2023.
//

import UIKit

final class MainModuleConfigurator {

    func configure(router: MainRouterInput) -> MainViewController {
        let view = MainViewController()
        let presenter = MainPresenter(
            view: view,
            router: router,
            networkService: NetworkService.shared
        )
        view.output = presenter
        return view
    }
}
