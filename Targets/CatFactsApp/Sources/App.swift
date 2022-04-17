//
//  App.swift
//  CatFactsApp
//
//  Created by Vasnev Anton Mikhaylovich on 17.04.2022.
//  Copyright © 2022 CatFacts.io. All rights reserved.
//

import Foundation
import CatFactsNetworkService
import CatFactsDomain
import CatFactsUI

enum App {

	// MARK: - Typealias

	typealias Dispatch = (Event) -> Void

	// MARK: - State

	struct State {
		static var initial: Self {
			.init(domainState: .initial)
		}
		var domainState: CatFactsDomain.State
	}

	// MARK: - Event

	enum Event {
		case domainInput(CatFactsDomain.Input)
		case appDelegate(AppDelegate.Event)
	}

	// MARK: - Effect

	enum Effect {
		case domainOutput(CatFactsDomain.Output)
		case showAskMoreCatFactssAlert
	}

	// MARK: - Private Properties

	private(set) static var store = Store<State, Event, Effect>(
		state: .initial,
		update: update,
		performer: perform,
		queue: .main
	)

	private static var dependencies = Dependencies()

	// MARK: - Private Functions

	private static func update(_ state: inout State, with event: Event) -> [Effect] {
		switch event {
		case .domainInput(let domainInput):
			let domainOutputs = CatFactsDomain.update(&state.domainState, with: domainInput)
			return domainOutputs.map { .domainOutput($0) }
		case .appDelegate(let appDelegateEvent):
			switch appDelegateEvent {
			case .didFinishLaunching(let rootViewController):
				dependencies.rootViewController = rootViewController
				return [.showAskMoreCatFactssAlert]
			}
		}
	}

	private static func perform(effect: Effect, dispatch: @escaping Dispatch) {
		switch effect {
		case .domainOutput(let domainOutput):
			switch domainOutput {
			case .requestCatFactsFromNetwork:
				RequestCatFactsFromNetworkPerformer.perform(
					getFact: { completion in
						dependencies.catFactsNetworkService.getFact(completion: completion)
					},
					dispatch: dispatch
				)

			case .confirmMoreCatFactssDemand:
				ConfirmMoreCatFactssDemandAlertPerformer.perform(viewController: dependencies.rootViewController!, dispatch: store.dispatch)
			}
		case .showAskMoreCatFactssAlert:
			ConfirmMoreCatFactssDemandAlertPerformer.perform(viewController: dependencies.rootViewController!, dispatch: store.dispatch)
		}
	}
}
