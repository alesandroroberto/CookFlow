//
//  CatalogStateTemlate.swift
//  CookFlow
//
//  Created by Ivan Sukhov on 04.04.2021.
//

import Foundation

extension Array where Element == CatalogBlock {
    static let testCatalogPage: [Element] = [
        CatalogBlock(title: "Soup",
                     description: "Tasty, very tasty"),
        CatalogBlock(title: "Pasta",
                     description: "Belissimo")
    ]
}
