//
//  CatFactDomainTests.swift
//  CatFactDomainTests
//
//  Created by Vasnev Anton Mikhaylovich on 17.04.2022.
//  Copyright © 2022 CatFact.io. All rights reserved.
//

import XCTest
import CatFactDomain

class CatFactDomainTests: XCTestCase {

	func test_catFactDemand() throws {
		var state = CatFactDomain.State.initial
		let input = CatFactDomain.Input.catFactDemand

		let outputs = CatFactDomain.update(&state, with: input)

		XCTAssertEqual(outputs, [.requestCatFactFromNetwork])
	}

	func test_apiRespondedWithCatFact() throws {
		var state = CatFactDomain.State.initial
		let input = CatFactDomain.Input.apiRespondedWithCatFact("All Cats Are Beautiful")

		let outputs = CatFactDomain.update(&state, with: input)

		XCTAssertEqual(outputs, [.confirmMoreCatFactsDemand])
	}
}
