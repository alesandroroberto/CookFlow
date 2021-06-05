//
//  CatalogState.swift
//  CookFlow
//
//  Created by Ivan Sukhov on 04.04.2021.
//

import Foundation
import Combine

typealias CatalogViewState = ViewState<CatalogState, CatalogEvent, CatalogSideEffect>

struct CatalogState: Equatable {
    var uuid: UUID
    var blocks: [CatalogBlock]
}

enum CatalogEvent {
    case loadContent
    case contentLoaded([CatalogBlock])
}

func catalogReducer(state: inout CatalogState, event: CatalogEvent) -> [SideEffect<CatalogSideEffect>] {
    var sideEffects = [SideEffect<CatalogSideEffect>]()
    switch event {
    case .loadContent:
        sideEffects.append(.moduleEffect(.loadContent(state.uuid)))
    case .contentLoaded(let blocks):
        state.blocks = blocks
    }
    return sideEffects
}

struct CatalogBlock: Equatable, Hashable {
    let title: String
    let description: String
}

enum CatalogSideEffect {
    case loadContent(UUID)
}

func catalogSideEffects(load: @escaping (UUID) -> Future<[CatalogBlock], Never>) -> (CatalogSideEffect) -> AnyPublisher<CatalogEvent, Never> {
    return { event in
        switch event {
        case .loadContent(let id):
            return load(id).map { .contentLoaded($0) }.eraseToAnyPublisher()
        }
    }
}

extension CatalogState {
    static let initial = CatalogState(uuid: UUID(), blocks: [])
}
