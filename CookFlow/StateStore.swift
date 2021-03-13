//
//  HeroinMVVM.swift
//  MelnikKitchen
//
//  Created by Alexander Krupichko on 06.03.2021.
//

import Combine
import SwiftUI
import Foundation

enum SideEffect<E> {
    case killSideEffect(UUID)
    case moduleSideEffect(UUID, E)
    
    static func moduleEffect(_ effect: E) -> SideEffect { .moduleSideEffect(UUID(), effect) }
}

class StateStore<State, Event, EffectEvent> {
    private var stateStore: CurrentValueSubject<State, Never>
    private var effectCancellables: [UUID: AnyCancellable] = [:]
    private let reducer: (inout State, Event) -> [SideEffect<EffectEvent>]
    private let runSideEffect: (EffectEvent) -> AnyPublisher<Event, Never>
    
    var output: AnyPublisher<State, Never> { stateStore.eraseToAnyPublisher() }
    
    init(
        initialState: State,
        reducer: @escaping (inout State, Event) -> [SideEffect<EffectEvent>],
        runSideEffect: @escaping (EffectEvent) -> AnyPublisher<Event, Never>
    ) {
        self.stateStore = .init(initialState)
        self.reducer = reducer
        self.runSideEffect = runSideEffect
    }
    
    func send(event: Event) {
        let effects = self.reducer(&stateStore.value, event)
        
        var didComplete = false
        
        for effect in effects {
            switch effect {
            case let .killSideEffect(uuid):
                self.effectCancellables[uuid] = nil
            case let .moduleSideEffect(uuid, effect):
                let effectCancellable = runSideEffect(effect).sink(
                    receiveCompletion: { [weak self] _ in
                        didComplete = true
                        self?.effectCancellables[uuid] = nil
                    },
                    receiveValue: { [weak self] action in
                        self?.send(event: action)
                    }
                )
                
                if !didComplete {
                    self.effectCancellables[uuid] = effectCancellable
                }
            }
        }
    }
}
