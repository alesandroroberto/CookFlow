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
                CatalogView(
                    state: .init(
                        initialState: .initial,
                        reducer: catalogReducer,
                        runSideEffect: catalogSideEffects(load: { _ in Future { promise in
                            promise(.success(.testCatalogPage))
                        }
                        })
                    )
                )
            }
        }
    }
}
