//
//  APILibraryTests.swift
//  GoodBitsStoreTests
//
//  Created by Sukumar Anup Sukumaran on 18/08/20.
//  Copyright © 2020 Tech_Tonic. All rights reserved.
//

import XCTest
@testable import GoodBitsStore

class APILibraryTests: XCTestCase {

    var sut: APILibrary!
    
    override func setUpWithError() throws {
        sut = APILibrary()
    }

    override func tearDownWithError() throws {
        sut = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    
    func testGetPickUpLocAPI() {
        
        let expect = XCTestExpectation(description: "callback")
        
        sut.apiPickupLocations(filterId: "1") { (response) in
            expect.fulfill()
            switch response {
            case .success(let data):
                XCTAssertNotNil(data.pickupLocationsModel)
                
            case .failure(errorStr: let error):
                XCTFail(error.errorStr)
            }
        }
        
        wait(for: [expect], timeout: 3.1)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
