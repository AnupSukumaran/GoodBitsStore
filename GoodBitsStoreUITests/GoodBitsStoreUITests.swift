//
//  GoodBitsStoreUITests.swift
//  GoodBitsStoreUITests
//
//  Created by Sukumar Anup Sukumaran on 17/08/20.
//  Copyright © 2020 Tech_Tonic. All rights reserved.
//

import XCTest

class GoodBitsStoreUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        XCUIApplication().launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func test1HomePageScene() {
        let app = XCUIApplication()
        let frontTxt = app.staticTexts["GoodBits"]
        XCTAssertTrue(frontTxt.exists)
    }
    
    func test2TablePullTest() {
        let app = XCUIApplication()
        
        let locbtn = app.navigationBars["GoodBits"].buttons["locOn"]
        
        XCTAssertTrue(locbtn.exists)
        locbtn.tap()

        let locOffbtn = app.navigationBars["GoodBits"].buttons["locOff"]
        XCTAssertTrue(locOffbtn.exists)
        
        locOffbtn.tap()
                               
                
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
