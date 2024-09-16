//
//  TCASamplesAppTests.swift
//  TCASamplesAppTests
//
//  Created by Emiaostein on 2024/9/9.
//

import XCTest
import ComposableArchitecture
@testable import TCASamplesApp

final class TCASamplesAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFeature() async {
//        let store = await TestStore(initialState: Feature.State()) {
//            Feature()
//        } withDependencies: { dvs in
//            dvs.numberFact.fetch = {"\($0) is a good number"}
//        }
        
        let store = await TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
                .dependency(\.numberFact, .testValue)
        }

        
        await store.send(.incrementButtonTapped) {
            $0.count = 1
        }
        
        await store.send(.decrementButtonTapped) {
            $0.count = 0
        }
        
        await store.send(.numberFactButtonTapped)
        
        await store.receive(\.numberFactResponse) {
            $0.numberFact = "0 is a good number."
        }
    }

}
