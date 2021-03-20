//
//  RecipeViewConverter.swift
//  CookFlow
//
//  Created by Alexander Krupichko on 20.03.2021.
//

import SwiftUI

extension RecipeBlock {
    var view: AnyView {
        switch self {
        case .title(let text):
            return Text(text).titleStyle()
        case .text(let text):
            return Text(text).textStyle()
        case .photo(let url):
            return AnyView(RemoteImage(url: url).bigImage())
        case .photoGrid(let urls):
            return AnyView(SmallPhotosGrid(photoUrls: urls))
        }
    }
}
