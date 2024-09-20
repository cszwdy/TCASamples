//
//  AllFeaturesView.swift
//  TCASamplesApp
//
//  Created by Emiaostein on 2024/9/16.
//

import Foundation
import SwiftUI
import ComposableArchitecture


struct AppView: View {
    @State var store: StoreOf<AppFeature>
    var body: some View {
        Text("\(store.counter?.count ?? 123)")
        Text("\(store.count)")
        Text(store.numberFact ?? "Empty")
        Text(store.name)
        Button("Counter") {
            // 这里怎么写
            store.send(.counterButtonTapped)
        }
        .sheet(item: $store.scope(state: \.counter, action: \.counter)) { astore in
            CounterFeatureView(store: astore)
        }
    }
    
}

#Preview {
    AppView(store: Store(initialState: AppFeature.State(), reducer: {
        AppFeature()
    }))
}



@Reducer
struct AppFeature {
    
    @ObservableState
    struct State {
        @Presents var counter: CounterFeature.State?
        @Shared(.appStorage("Name")) var name = "Emiaostein"
        var count = 0
        var numberFact: String?
    }
    
    enum Action {
        case counter(PresentationAction<CounterFeature.Action>)
        case counterButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .counterButtonTapped:
                state.counter = CounterFeature.State(count: state.count)
                return .none
            case .counter(.presented(.incrementButtonTapped)):
                state.count = state.counter?.count ?? 999
                return .none
            case .counter(.dismiss):
                return .none
            case .counter(.presented(.decrementButtonTapped)):
                state.count = state.counter?.count ?? 999
                return .none
            case .counter(.presented(.numberFactButtonTapped)):
                return .none
            case .counter(.presented(.numberFactResponse(_))):
                state.numberFact = state.counter?.numberFact ?? "Empty"
                return .none
            }
        }
        .ifLet(\.$counter, action: \.counter) {
            CounterFeature()
        }
    }
}
