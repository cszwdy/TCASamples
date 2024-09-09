//
//  FeatureView.swift
//  TCASamplesApp
//
//  Created by Emiaostein on 2024/9/9.
//

import SwiftUI
import ComposableArchitecture

struct FeatureView: View {
    let store: StoreOf<Feature>
    
    var body: some View {
        Form {
            Section {
                Text("\(store.count)")
                Button(" - ") {store.send(.decrementButtonTapped)}
                Button(" + ") {store.send(.incrementButtonTapped)}
            }
            
            Section {
                Button("Number fact") {store.send(.numberFactButtonTapped)}
            }
            
            if let fact = store.numberFact {
                Text(fact)
            }
        }
    }
}

#Preview {
    FeatureView(
        store: Store(initialState: Feature.State()) {Feature()}
    )
}

