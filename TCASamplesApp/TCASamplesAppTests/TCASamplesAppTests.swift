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

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFeature() async {
//        let store = await TestStore(initialState: Feature.State()) {
//            Feature()
//        } withDependencies: { dvs in
//            dvs.numberFact.fetch = {"\($0) is a good number"}
//        }
        
        let store = await TestStore(initialState: Feature.State()) {
            Feature()
                .dependency(\.numberFact, .testValue)
        }

        
        await store.send(.incrementButtonTapped) {
            $0.count = 1
            $0.name = "+"
            $0.age = 2
            $0.married = true
            $0.cool = true
        }
        
        await store.send(.decrementButtonTapped) {
            $0.count = 0
            $0.name = "-"
            $0.age = 1
            $0.married = false
            $0.cool = false
        }
        
        await store.send(.numberFactButtonTapped)
        
        await store.receive(\.numberFactResponse) {
            $0.numberFact = "0 is a good number."
        }
    }

}
