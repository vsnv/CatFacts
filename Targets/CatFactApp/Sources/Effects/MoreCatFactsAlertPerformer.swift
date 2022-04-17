//
//  MoreCatFactsAlertPerformer.swift
//  CatFactApp
//
//  Created by Vasnev Anton Mikhaylovich on 17.04.2022.
//  Copyright © 2022 tuist.io. All rights reserved.
//

import UIKit

enum MoreCatFactsAlertPerformer {
	static func perform(viewController: UIViewController, dispatch: @escaping App.Dispatch) {
		let alert = UIAlertController(
			title: "More Cat Facts?",
			message: nil,
			preferredStyle: .alert
		)
		let action = UIAlertAction(title: "One more fact, please", style: .default) { _ in
			dispatch(.domainInput(.catFactDemand))
		}
		alert.addAction(action)
		viewController.present(alert, animated: true)
	}
}
