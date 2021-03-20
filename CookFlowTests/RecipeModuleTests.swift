//
//  RecipeModuleTests.swift
//  CookFlowTests
//
//  Created by Alexander Krupichko on 20.03.2021.
//

import XCTest
import Combine
@testable import CookFlow

class RecipeModuleTests: XCTestCase {
    let recipeId = UUID()
    var initialState: RecipeState { .init(uuid: self.recipeId, blocks: []) }
    
    func testLoadRecipeContent() {
        var cancelable = Set<AnyCancellable>()
            
        var result: RecipeState = initialState
        let loadedContent: [RecipeBlock] = [.text("as"), .title("as")]
        
        let store = StateStore<RecipeState, RecipeEvent, RecipeSideEffect>(
            initialState: initialState,
            reducer: recipeReducer,
            runSideEffect: recipeSideEffects(load: { _ in Future { promise in
                promise(.success(loadedContent))
            } })
        )
        store.output.sink(receiveValue: { result = $0 }).store(in: &cancelable)
        
        store.send(event: .loadContent)
        
        XCTAssertEqual(result, .init(uuid: recipeId, blocks: loadedContent))
    }
}
