//
//  ConcurrencyTestTests.swift
//  ConcurrencyTestTests
//


import XCTest
@testable import ConcurrencyTest

class ConcurrencyTests: XCTestCase {
    
    let successfulGreetingMessage = "Hello world!"
     
     func testloadMessageSuccessfully() {
         let expectation = XCTestExpectation(description: "Load message")
         //make sure timeout is longer than maxium loading time
         let loadingTimeout = DispatchTimeInterval.milliseconds(3000)
         
         loadGreetingMessage(timeout: loadingTimeout) { (message) in
             XCTAssertNotNil(message)
             XCTAssert(message == self.successfulGreetingMessage)
             expectation.fulfill()
         }
         wait(for: [expectation], timeout: 10.0)
     }

}
