//
//  AlertController.swift
//  RickAndMorty
//
//  Created by Vadim Kim on 22.08.2023.
//

import UIKit

final class AlertController: UIAlertController {

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = String(localized: "alert.title")

        let cancelAction = UIAlertAction(
            title: String(localized: "alert.cancel"),
            style: .cancel,
            handler: nil
        )

        self.addAction(cancelAction)
    }
}
