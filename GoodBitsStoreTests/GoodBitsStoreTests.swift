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
        
        XCTAssertEqual(distance, 1.452622540522926)
    }
    
    func testDecimalpoints() {
        let val = 1001.56789.toDecimalsStr(2)
        XCTAssertEqual(val, "1001.57")
    }
    
    func testMeterToKm() {
        let val = 2568.meterToKm()
        XCTAssertEqual(val, 2.568)
    }


}
