//
//  Feature.swift
//  TCASamplesApp
//
//  Created by Emiaostein on 2024/9/9.
//

import Foundation
import ComposableArchitecture


@Reducer
struct CounterFeature {
    @ObservableState
    struct State: Equatable {
        @Shared(.appStorage("Name")) var name = "Good Morning"
        var count = 0
        var numberFact = ""
    }
    enum Action {
        case decrementButtonTapped
        case incrementButtonTapped
        case numberFactButtonTapped
        case numberFactResponse(String)
    }
    @Dependency(\.numberFact) var numberFact
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
                
            case .decrementButtonTapped:
                state.count -= 1
                return .none
            case .incrementButtonTapped:
                state.count += 1
                return .none
            case .numberFactButtonTapped:
                return .run {[count = state.count] send in
                    let fact = try await self.numberFact.fetch(count)
                    await send(.numberFactResponse(fact))
                }
            case let .numberFactResponse(fact):
                state.numberFact = fact
                state.name = fact
                return .none
            }
        }
    }
}

struct NumberFactClient {
    var fetch: (Int) async throws -> String
}

extension NumberFactClient: DependencyKey {
    static var liveValue: NumberFactClient {
        Self { number in
            let (data, _) = try await URLSession.shared.data(from: URL(string: "http://numbersapi.com/\(number)")!)
            return String(decoding: data, as: UTF8.self)
        }
    }
    
    
    static var testValue: NumberFactClient {
        Self { number in
            return "\(number) is a good number."
        }
    }
}

extension DependencyValues {
    var numberFact: NumberFactClient {
        get {self[NumberFactClient.self]}
        set {self[NumberFactClient.self] = newValue}
    }
}
