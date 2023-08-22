//
//  Images.swift
//  RickAndMorty
//
//  Created by Vadim Kim on 22.08.2023.
//

import UIKit

enum Images: String {

    // MARK: - Custom images

    case noImageData
    case arrowLeft = "chevron.left"

    // MARK: - System images

    case planetIcon

    // MARK: - Properties

    var image: UIImage? {
        UIImage(named: rawValue)
    }

    var systemImage: UIImage? {
        UIImage(systemName: rawValue)
    }
}
