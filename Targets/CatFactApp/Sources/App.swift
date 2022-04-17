//
//  App.swift
//  CatFactApp
//
//  Created by Vasnev Anton Mikhaylovich on 17.04.2022.
//  Copyright © 2022 CatFact.io. All rights reserved.
//

import Foundation
import CatFactNetworkService
import CatFactDomain
import CatFactUI

enum App {

	// MARK: - Typealias

	typealias Dispatch = (Event) -> Void

	// MARK: - State

	struct State {
		static var initial: Self {
			.init(domainState: .initial)
		}
		var domainState: CatFactDomain.State
	}

	// MARK: - Event

	enum Event {
		case domainInput(CatFactDomain.Input)
		case appDelegate(AppDelegate.Event)
	}

	// MARK: - Effect

	enum Effect {
		case domainOutput(CatFactDomain.Output)
		case showAskMoreCatFactsAlert
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
			let domainOutputs = CatFactDomain.update(&state.domainState, with: domainInput)
			return domainOutputs.map { .domainOutput($0) }
		case .appDelegate(let appDelegateEvent):
			switch appDelegateEvent {
			case .didFinishLaunching(let rootViewController):
				dependencies.rootViewController = rootViewController
				return [.showAskMoreCatFactsAlert]
			}
		}
	}

	private static func perform(effect: Effect, dispatch: @escaping Dispatch) {
		switch effect {
		case .domainOutput(let domainOutput):
			switch domainOutput {
			case .requestCatFactFromNetwork:
				GetCatFactFromNetworkPerformer.perform(
					getFact: { completion in
						dependencies.catFactNetworking.getFact(completion: completion)
					},
					dispatch: dispatch
				)

			case .confirmMoreCatFactsDemand:
				MoreCatFactsAlertPerformer.perform(viewController: dependencies.rootViewController!, dispatch: store.dispatch)
			}
		case .showAskMoreCatFactsAlert:
			MoreCatFactsAlertPerformer.perform(viewController: dependencies.rootViewController!, dispatch: store.dispatch)
		}
	}
}
