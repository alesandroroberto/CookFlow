//
//  RecipeState.swift
//  CookFlow
//
//  Created by Alexander Krupichko on 20.03.2021.
//

import Foundation
import Combine

typealias RecipeViewState = ViewState<RecipeState, RecipeEvent, RecipeSideEffect>

struct RecipeState: Equatable {
    var uuid: UUID
    var blocks: [RecipeBlock]
}

enum RecipeEvent {
    case loadContent
    case contentLoaded([RecipeBlock])
}

func recipeReducer(state: inout RecipeState, event: RecipeEvent) -> [SideEffect<RecipeSideEffect>] {
    var sideEffects = [SideEffect<RecipeSideEffect>]()
    switch event {
    case .loadContent:
        sideEffects.append(.moduleEffect(.loadContent(state.uuid)))
    case .contentLoaded(let blocks):
        state.blocks = blocks
    }
    return sideEffects
}

enum RecipeBlock: Equatable {
    case title(String)
    case text(String)
    case photo(URL)
    case photoGrid([URL])
}

enum RecipeSideEffect {
    case loadContent(UUID)
}

func recipeSideEffects(load: @escaping (UUID) -> Future<[RecipeBlock], Never>)
-> (RecipeSideEffect) -> AnyPublisher<RecipeEvent, Never> {
    return { event in
        switch event {
        case .loadContent(let id):
            return load(id).map { .contentLoaded($0) }.eraseToAnyPublisher()
        }
    }
}

extension RecipeBlock: Hashable {
    var id: String {
        switch self {
        case .title(let text), .text(let text):
            return text
        case .photo(let url):
            return url.absoluteString
        case .photoGrid(let urls):
            return urls.map(\.absoluteString).joined()
        }
    }
}

extension RecipeState {
    static let initial = RecipeState(uuid: UUID(), blocks: [])
}
