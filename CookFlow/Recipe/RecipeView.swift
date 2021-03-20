//
//  RecipeView.swift
//  CookFlow
//
//  Created by Alexander Krupichko on 20.03.2021.
//

import SwiftUI
import Combine

struct RecipeView: View {
    @StateObject var state: RecipeViewState
    
    var body: some View {
        ScrollView() {
            VStack() {
                ForEach(state.stateValue.blocks, id: \.self) { $0.view }
            }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .top)
        }.onAppear(perform: { state.send(event: .loadContent) })
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(
            state: .init(
                initialState: .init(
                    uuid: UUID(),
                    blocks: [
                        .title("Penis title"),
                        .text("Penis penis text\nand another text\nand another text"),
                        .photo(URL(string: "https://cookflow.ru")!),
                        .photoGrid(Array(0..<12).map { URL(string: "https://cookflow\($0).ru")! }),
                        .text("Penis penis text\nand another text\nand another text")
                    ]
                ),
                reducer: recipeReducer,
                runSideEffect: recipeSideEffects(load: { _ in Future { promise in
                    promise(.success([]))
                  } }))
        )
    }
}
