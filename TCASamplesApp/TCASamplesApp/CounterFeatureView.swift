//
//  FeatureView.swift
//  TCASamplesApp
//
//  Created by Emiaostein on 2024/9/9.
//

import SwiftUI
import ComposableArchitecture

struct CounterFeatureView: View {
    var store: StoreOf<CounterFeature>
    
    var body: some View {
        Form {
            Section {
                Text("\(store.count)")
                Button(" - ") {
                    store.send(.decrementButtonTapped)
                }
                Button(" + ") {store.send(.incrementButtonTapped)}
            }
            
            Section {
                Button("Number fact") {store.send(.numberFactButtonTapped)}
            }
            
            if let fact = store.numberFact {
                Text(fact)
            }
            Text(store.name)
        }
    }
}

#Preview {
    CounterFeatureView(
        store: Store(initialState: CounterFeature.State()) {CounterFeature()}
    )
}

