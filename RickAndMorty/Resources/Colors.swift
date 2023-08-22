//
//  Colors.swift
//  RickAndMorty
//
//  Created by Vadim Kim on 19.08.2023.
//

import UIKit

enum Colors: String {
    case darkBlue
    case white
    case gray
    case green
    case lightGray

    // MARK: - Properties

    var color: UIColor {
        UIColor(named: rawValue) ?? UIColor.clear
    }

    var cgColor: CGColor {
        UIColor(named: rawValue)?.cgColor ?? UIColor().cgColor
    }
}
