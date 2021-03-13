//
//  CookFlowApp.swift
//  CookFlow
//
//  Created by a.krupichko on 13.03.2021.
//

import SwiftUI

@main
struct MelnikKitchenApp: App {
    @StateObject var state = TestViewState(
        initialState: .initial,
        reducer: testReducer,
        runSideEffect: sideEffectConverter
    )
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(state)
        }
    }
}
