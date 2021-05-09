//
//  ProgressView.swift
//  CookFlow
//
//  Created by Alexander Krupichko on 08.05.2021.
//

import SwiftUI
import Combine

struct ProgressView: View {
    @StateObject private var state = ProgressObservable()
    
    var body: some View {
        HStack() {
            ProgressShape(state.stateValue.progressFirst)
            ProgressShape(state.stateValue.progressSecond)
            ProgressShape(state.stateValue.progressThird)
        }.onAppear(perform: {
            state.startAnimation()
        })
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
    }
}

func negativeState(_ state: ProgressState) -> ProgressState {
    return .init(progress: -state.progress)
}

class ProgressObservable: ObservableObject {
    @Published private(set) var stateValue = ProgressViewState(
        progressFirst: .init(progress: 0),
        progressSecond: .init(progress: 1),
        progressThird: .init(progress: 0)
    )
    
    func startAnimation() {
        let animation = Animation.easeInOut(duration: 0.3).repeatForever()
        withAnimation(animation) {
            if self.stateValue.progressFirst.progress > 0 {
                self.stateValue.progressFirst.progress = 0
            } else {
                self.stateValue.progressFirst.progress = 1
            }
            if self.stateValue.progressSecond.progress > 0 {
                self.stateValue.progressSecond.progress = 0
            } else {
                self.stateValue.progressSecond.progress = 1
            }
            if self.stateValue.progressThird.progress > 0 {
                self.stateValue.progressThird.progress = 0
            } else {
                self.stateValue.progressThird.progress = 1
            }
        }
    }
}

struct ProgressViewState {
    var progressFirst: ProgressState
    var progressSecond: ProgressState
    var progressThird: ProgressState
}

struct ProgressState {
    var progress: CGFloat // 0-1
}

extension ProgressState: Animatable {
    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }
}

struct ProgressShape: Shape {
    var state: ProgressState
    init(_ state: ProgressState) { self.state = state }

    func path(in rect: CGRect) -> Path {
        let height: CGFloat
        if state.progress < 0 {
            height = -rect.size.height/2
        } else if state.progress > 1 {
            height = rect.size.height/2
        } else if state.progress <= 0.5 {
            let positiveProgressPercent = (state.progress / 0.5) - 1
            height = (rect.size.height/2) * positiveProgressPercent
        } else {
            let negativeProgressPercent = (state.progress - 0.5) / 0.5
            height = (rect.size.height/2) * negativeProgressPercent
        }
        
        var path = Path()
        path.move(
            to: .init(
                x: rect.origin.x,
                y: rect.origin.y + rect.size.height/2
            )
        )
        path.addCurve(
            to: .init(
                x: rect.origin.x + rect.size.width,
                y: rect.origin.y + rect.size.height/2
            ),
            control1: .init(
                x: rect.origin.x + rect.size.width/3,
                y: rect.origin.y + rect.size.height/2 + height
            ),
            control2: .init(
                x: rect.origin.x + ((rect.size.width/3) * 2),
                y: rect.origin.y + rect.size.height/2 + height
            )
        )
        path.closeSubpath()
        return path
    }

    var animatableData: CGFloat {
        get {
            state.animatableData
        }
        set {
            state.animatableData = newValue
        }
    }
}
