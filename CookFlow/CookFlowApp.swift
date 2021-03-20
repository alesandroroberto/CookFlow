//
//  CookFlowApp.swift
//  CookFlow
//
//  Created by a.krupichko on 13.03.2021.
//

import SwiftUI
import Combine

@main
struct MelnikKitchenApp: App {
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                RecipeView(
                    state: .init(
                        initialState: .initial,
                        reducer: recipeReducer,
                        runSideEffect: recipeSideEffects(load: { _ in Future { promise in
                            promise(.success(.testRecipePage))
                        }
                        })
                    )
                ).navigationBarTitle(Text("Рецепты"))
            }
        }
    }
}
