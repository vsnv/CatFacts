//
//  GetCatFactsFromNetworkPerformerTests.swift
//  CatFactsAppTests
//
//  Created by Vasnev Anton Mikhaylovich on 17.04.2022.
//  Copyright © 2022 CatFacts.io. All rights reserved.
//

import XCTest
@testable import CatFactsNetworkService
@testable import CatFactsApp

class GetCatFactsFromNetworkPerformerTests: XCTestCase {

	func test_perform() throws {

		let expectation = expectation(description: "wait for getFact call")

		let getFact: (@escaping (Result<CatFactsNetworkResponse, CatFactsNetworkError>) -> Void) -> Void = { completion in
			completion(.success(.init(fact: "All Cats Are Beautiful", length: 0)))

		}
		let dispatch: (App.Event) -> Void = { event in
			switch event {
			case .domainInput(let domainInput):
				switch domainInput {
				case .catFactDemand:
					XCTFail("Wrong input")
				case .networkRespondedWithCatFact(let catFact):
					XCTAssertEqual(catFact, "All Cats Are Beautiful", "Wrong input")
				}
			case .appDelegate(_):
				XCTFail("Wrong input")
			}

			expectation.fulfill()
		}

		GetCatFactsFromNetworkPerformer.perform(getFact: getFact, dispatch: dispatch)

		waitForExpectations(timeout: 1)
	}
}
