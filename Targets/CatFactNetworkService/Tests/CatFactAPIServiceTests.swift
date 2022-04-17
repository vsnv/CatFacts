//
//  CatFactNetworkServiceIntegrationTests.swift
//  CatFactNetworkService
//
//  Created by Vasnev Anton Mikhaylovich on 17.04.2022.
//  Copyright © 2022 tuist.io. All rights reserved.
//

import XCTest
import CatFactNetworking

/// Integrational tests with real API
class CatFactNetworkServiceIntegrationTests: XCTestCase {

	func test_getFact() throws {
		let sut = CatFactNetworking()
		let getFactExpectation = expectation(description: "waiting for response")
		sut.getFact { result in
			switch result {
			case .success:
				break
			case .failure(let error):
				XCTFail("getFact failed with error: \(error.localizedDescription)")
			}
			getFactExpectation.fulfill()
		}
		waitForExpectations(timeout: 3)
	}
}
