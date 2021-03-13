//
//  ContentView.swift
//  MelnikKitchen
//
//  Created by Alexander Krupichko on 27.02.2021.
//

import SwiftUI
import Combine

struct ContentView: View {
    @EnvironmentObject var state: TestViewState
    
    var body: some View {
        VStack() {
            Text(state.stateValue.timerValue.map { "\($0.timeIntervalSince1970)" } ?? "0")
                .padding()
            Button("Пенис", action: { state.send(event: .timerToggle) })
                .padding(10)
                .background(Color(.blue)).cornerRadius(10)
                .accentColor(.white)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(
                TestViewState(
                    initialState: .initial,
                    reducer: { _, _ in [] },
                    runSideEffect: { _ in Empty().eraseToAnyPublisher() }
                )
            )
    }
}
