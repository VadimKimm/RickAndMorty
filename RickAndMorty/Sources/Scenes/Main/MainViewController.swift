//
//  MainViewController.swift
//  RickAndMorty
//
//  Created by Vadim Kim on 19.08.2023.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Properties

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
        title = "Characters"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
