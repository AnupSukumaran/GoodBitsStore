//
//  GoodBitsStoreTests.swift
//  GoodBitsStoreTests
//
//  Created by Sukumar Anup Sukumaran on 17/08/20.
//  Copyright © 2020 Tech_Tonic. All rights reserved.
//

import XCTest
@testable import GoodBitsStore

class GoodBitsStoreTests: XCTestCase {

    var sut: HomePickupLocViewModel!
    
    override func setUpWithError() throws {
        sut = HomePickupLocViewModel()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        sut = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDistanceBtwCoords() {
        let distance = getDistance(coord1: (lat: 9.981391906738281, long: 76.30953697494819), coord2: (lat: 9.992127, long: 76.301905))
        
        XCTAssertEqual(distance, 1452.622540522926)
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
