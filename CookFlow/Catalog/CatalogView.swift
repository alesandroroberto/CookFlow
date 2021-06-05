//
//  CatalogView.swift
//  CookFlow
//
//  Created by Ivan Sukhov on 04.04.2021.
//

import SwiftUI
import Combine

struct CatalogView: View {
    @StateObject var state: CatalogViewState
    
    var body: some View {
            List {
                ForEach(state.stateValue.blocks, id: \.self) {
                    $0.view
                }
            }.onAppear(perform: { state.send(event: .loadContent) })
            .navigationBarTitle(Text("Рецепты"))
    }
}

struct CatalogView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogView(
            state: .init(
                initialState: .init(
                    uuid: UUID(),
                    blocks: [
                        CatalogBlock(title: "Tiger title",
                                     description: "Tiger text")
                    ]
                ),
                reducer: catalogReducer,
                runSideEffect: catalogSideEffects(load: { _ in Future { promise in
                    promise(.success([]))
                }
                })
            )
        )
    }
}
