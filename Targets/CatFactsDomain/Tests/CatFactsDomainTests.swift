//
//  CatFactsDomainTests.swift
//  CatFactsDomainTests
//
//  Created by Vasnev Anton Mikhaylovich on 17.04.2022.
//  Copyright © 2022 CatFacts.io. All rights reserved.
//

import XCTest
import CatFactsDomain

class CatFactsDomainTests: XCTestCase {

	func test_catFactDemand() throws {
		var state = CatFactsDomain.State.initial
		let input = CatFactsDomain.Input.catFactDemand

		let outputs = CatFactsDomain.update(&state, with: input)

		XCTAssertEqual(outputs, [.requestCatFactsFromNetwork])
	}

	func test_apiRespondedWithCatFacts() throws {
		var state = CatFactsDomain.State.initial
		let input = CatFactsDomain.Input.networkRespondedWithCatFact("All Cats Are Beautiful")

		let outputs = CatFactsDomain.update(&state, with: input)

		XCTAssertEqual(outputs, [.confirmMoreCatFactssDemand])
	}
}
