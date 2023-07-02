//
//  Validation_Api_service.swift
//  SSpaceXTests
//
//  Created by yahya on 7/1/23.
//

import XCTest
@testable import SSpaceX

final class Validation_Api_service: XCTestCase {
    let membershipApi = MembershipRepository()

    func test_api_is_valid() {
        let expectation = self.expectation(description: "ready")
        membershipApi.getMission(query: MissionRequestModel.createRequestLuncher(page: 1)) { result in
            switch result {
            case .success(let model):
                
                XCTAssertTrue(model.mission != nil)
                expectation.fulfill()
                
            case .failure(_):
                XCTFail("Error in apo test")
                expectation.fulfill()
            }
            
        }
        self.waitForExpectations(timeout: 5, handler: nil)

        
    }

}
