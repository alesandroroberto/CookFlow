//
//  ViewState.swift
//  MelnikKitchen
//
//  Created by a.krupichko on 13.03.2021.
//

import Combine
import Foundation

final class ViewState<State: Equatable, Event, StoreSideEffect>: ObservableObject {
    private var cancellableBag = Set<AnyCancellable>()
    private let store: StateStore<State, Event, StoreSideEffect>
    
    @Published private(set) var stateValue: State
    
    init(
        initialState: State,
        reducer: @escaping (inout State, Event) -> [SideEffect<StoreSideEffect>],
        runSideEffect: @escaping (StoreSideEffect) -> AnyPublisher<Event, Never>
    ) {
        stateValue = initialState
        store = .init(
            initialState: initialState,
            reducer: reducer,
            runSideEffect: runSideEffect
        )
        
        store.output
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .sink(receiveCompletion: { [weak self] _ in self?.cancellableBag = [] }) { [weak self] state in
            self?.stateValue = state
        }.store(in: &cancellableBag)
    }
    
    func send(event: Event) {
        store.send(event: event)
    }
}
