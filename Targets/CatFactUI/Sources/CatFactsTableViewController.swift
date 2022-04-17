//
//  ExampleTableViewController.swift
//  CatFactUI
//
//  Created by Vasnev Anton Mikhaylovich on 17.04.2022.
//  Copyright © 2022 CatFact.io. All rights reserved.
//

import UIKit

public final class CatFactsTableViewController: UITableViewController {

	// MARK: - Props

	public struct Props {
		public static var initial: Self {
			.init(title: "", cells: [])
		}
		public struct Cell {
			let labelText: String

			public init(labelText: String) {
				self.labelText = labelText
			}
		}
		var title: String
		var cells: [Cell]

		public init(title: String, cells: [Cell]) {
			self.title = title
			self.cells = cells
		}
	}

	// MARK: - Constants

	private enum Constants {
		static let reuseIdentifier = "reuseIdentifier"
	}

	// MARK: - Private Properties

	private var props = Props.initial {
		didSet {
			tableView.reloadData()
			title = props.title
		}
	}

	public override func viewDidLoad() {
		super.viewDidLoad()
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.reuseIdentifier)
	}

	// MARK: - Public Methods

	public func render(props: Props) {
		self.props = props
	}

	// MARK: - TableView DataSource

	public override func numberOfSections(in tableView: UITableView) -> Int { 1 }

	public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		props.cells.count
	}

	public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseIdentifier, for: indexPath)

		cell.textLabel?.text = props.cells[indexPath.row].labelText

		return cell
	}
}
