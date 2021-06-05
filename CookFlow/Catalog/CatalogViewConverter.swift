//
//  CatalogViewConverter.swift
//  CookFlow
//
//  Created by Ivan Sukhov on 04.04.2021.
//

import SwiftUI
import Combine

extension CatalogBlock {
    var view: AnyView {
        return AnyView (
            NavigationLink(
            destination: RecipeView(
                state: .init(
                    initialState: .initial,
                    reducer: recipeReducer,
                    runSideEffect: recipeSideEffects(load: { _ in Future { promise in
                        promise(.success(.testRecipePage))
                    }
                    })
                )
            ),
            label: {
                HStack() {
                    VStack() {
                        Text(title).titleStyle()
                        Text(description).textStyle()
                    }
                    RemoteImage(url: URL(string: "https://cdn.lifehacker.ru/wp-content/uploads/2018/05/tomatnyj-sup_1525442518-1140x570.jpg")!).bigImage()
                }
            }).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .top)
        )
    }
}
