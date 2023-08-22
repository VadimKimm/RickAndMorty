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
        title = Strings.title

        let cancelAction = UIAlertAction(title: Strings.cancel, style: .cancel, handler: nil)

        self.addAction(cancelAction)
    }

    // MARK: - Internal methods
}

extension AlertController {
    enum Strings {
        static let title = "Error occurred"
        static let cancel = "Cancel"
    }
}
