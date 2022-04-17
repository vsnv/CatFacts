//
//  App.swift
//  CatFactsApp
//
//  Created by Vasnev Anton Mikhaylovich on 17.04.2022.
//  Copyright © 2022 CatFacts.io. All rights reserved.
//

import UIKit
import CatFactsUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	enum Event {
		case didFinishLaunching(rootViewController: UIViewController)
	}

	var window: UIWindow?

	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
	) -> Bool {

		window = UIWindow(frame: UIScreen.main.bounds)

		let rootViewController = CatFactssTableViewController()
		window?.rootViewController = rootViewController
		window?.makeKeyAndVisible()

		App.store.dispatch(.appDelegate(.didFinishLaunching(rootViewController: rootViewController)))

		App.store.observe { state in
			DispatchQueue.main.async {
				rootViewController.render(props: .init(
					title: "Cat Facts",
					cells: state.domainState.catFacts.map { .init(labelText: $0) })
				)
			}
		}

		return true
	}
}
