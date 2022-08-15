//
//  UIColorExtensionTests.swift
//  Directory AppTests
//
//  Created by Kacper Cichosz on 23/07/2022.
//

import XCTest

class UIColorExtensionTests: XCTestCase {

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
    
    func testUIColorExtension_whenUsedHexInit () {
        // given
        let sut = UIColor.init(hexString: "#C40202")
        
        // then
        XCTAssertEqual(sut, UIColor(red: 196/255, green: 2/255, blue: 2/255, alpha: 255/255))
    }

}
