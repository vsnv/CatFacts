//
//  CatFactssTableViewControllerTests.swift
//  CatFactssTableViewControllerTests
//
//  Created by Vasnev Anton Mikhaylovich on 17.04.2022.
//  Copyright © 2022 CatFacts.io. All rights reserved.
//

import XCTest
import CatFactsUI

class CatFactssTableViewControllerTests: XCTestCase {

	func test_render() throws {
		let sut = CatFactssTableViewController()
		sut.render(props: .init(
			title: "TestTitle",
			cells: [
				.init(labelText: "Researchers are unsure exactly how a cat purrs."),
				.init(labelText: "In ancient Egypt, mummies were made of cats."),
				.init(labelText: "Cats have supersonic hearing")
			])
		)
		XCTAssertEqual(sut.title, "TestTitle", "Wrong title")
		XCTAssertEqual(sut.numberOfSections(in: sut.tableView), 1, "Wrong number of sections in table")
		XCTAssertEqual(sut.tableView(sut.tableView, numberOfRowsInSection: 0), 3, "Wrong number of rows in section")
		XCTAssertEqual(
			sut.tableView(sut.tableView, cellForRowAt: .init(row: 1, section: 0)).textLabel?.text,
			"In ancient Egypt, mummies were made of cats.",
			"Wrong cell label text"
		)
	}

}
