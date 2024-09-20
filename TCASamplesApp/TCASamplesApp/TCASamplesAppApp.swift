//
//  TCASamplesAppApp.swift
//  TCASamplesApp
//
//  Created by Emiaostein on 2024/9/9.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCASamplesAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
            AppView(store: Store(initialState: AppFeature.State(), reducer: {
                AppFeature()
            }))
            
//            CounterFeatureView(
//                store: Store(initialState: CounterFeature.State()) {
//                    CounterFeature()
//                }
//            )
        }
    }
}
