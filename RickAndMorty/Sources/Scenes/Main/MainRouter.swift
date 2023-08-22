//
//  MainRouter.swift
//  RickAndMorty
//
//  Created by Vadim Kim on 19.08.2023.
//

import UIKit

protocol MainRouterInput {
    func showDetailScreen(with model: Character)
    func backToRootViewController()
    func showAlert(with message: String)
}

final class MainRouter: MainRouterInput {

    var navigationController: UINavigationController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func setRootViewController() {
        guard let navigationController = navigationController else { return }
        let viewController = MainModuleConfigurator().configure(router: self)
        navigationController.viewControllers = [viewController]
    }

    func showDetailScreen(with model: Character) {
        guard let navigationController = navigationController else { return }
        let viewController = DetailCharacterModuleConfigurator().configure(router: self, with: model)
        navigationController.pushViewController(viewController, animated: true)
    }

    func showAlert(with message: String) {
        guard let navigationController = navigationController else { return }
        let alertController = AlertController(title: nil, message: message, preferredStyle: .alert)
        navigationController.present(alertController, animated: true)
    }

    func backToRootViewController() {
        guard let navigationController = navigationController else { return }
        navigationController.popToRootViewController(animated: true)
    }
}
