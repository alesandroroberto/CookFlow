//
//  TestState.swift
//  MelnikKitchen
//
//  Created by Alexander Krupichko on 06.03.2021.
//

import Foundation
import Combine

typealias TestViewState = ViewState<TestState, TestEvent, ModuleSideEffect>

struct TestState: Equatable {
    var timerStarted: Bool
    var timerValue: Date?
    var timerId: UUID?
}

enum TestEvent {
    case timerToggle
    case timerUpdated(value: Date)
}

extension TestState {
    static let initial = TestState(timerStarted: false, timerValue: nil, timerId: nil)
}

func testReducer(state: inout TestState, event: TestEvent) -> [SideEffect<ModuleSideEffect>] {
    var sideEffects = [SideEffect<ModuleSideEffect>]()
    switch event {
    case .timerToggle:
        state.timerStarted = !state.timerStarted
        if let timerId = state.timerId, !state.timerStarted {
            state.timerValue = nil
            sideEffects.append(.killSideEffect(timerId))
        } else if state.timerStarted {
            let timerId = UUID()
            state.timerId = timerId
            sideEffects.append(.moduleSideEffect(timerId, .startTimer))
        }
    case .timerUpdated(let value):
        state.timerValue = value
    }
    return sideEffects
}

enum ModuleSideEffect {
    case startTimer
}

func sideEffectConverter(event: ModuleSideEffect) -> AnyPublisher<TestEvent, Never> {
    switch event {
    case .startTimer:
        return Timer.publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
            .map { .timerUpdated(value: $0) }
            .eraseToAnyPublisher()
    }
}
