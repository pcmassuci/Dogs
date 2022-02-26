//
//  TabBarPage.swift
//  Dogs
//
//  Created by Paulo Cesar Morandi Massuci on 26/02/22.
//

import Foundation
import UIKit

enum TabBarPage: Int {
    case dogs = 0
    case search

    func pageTitleValue() -> String {
        switch self {
        case .dogs:
            return "Dogs"
        case .search:
            return "Search"
        }
    }

    func pageOrderNumber() -> Int {
        self.rawValue
    }

    func iconUnselected() -> UIImage? {
        switch self {
        case .dogs:
            return UIImage(named: "paw")
        case .search:
            return UIImage(systemName: "magnifyingglass")
        }
    }
}
