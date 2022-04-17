//
//  GetCatFactFromNetworkPerformerTests.swift
//  CatFactAppTests
//
//  Created by Vasnev Anton Mikhaylovich on 17.04.2022.
//  Copyright © 2022 CatFact.io. All rights reserved.
//

import XCTest
@testable import CatFactApp

class GetCatFactFromNetworkPerformerTests: XCTestCase {

	func testExample() throws {
		let viewController = UIViewController()
		let dispatch: (App.Event) -> Void = { _ in

		}

		MoreCatFactsAlertPerformer.perform(viewController: viewController, dispatch: dispatch)

		XCTAssertNotNil(viewController.presentedViewController)
	}
}
