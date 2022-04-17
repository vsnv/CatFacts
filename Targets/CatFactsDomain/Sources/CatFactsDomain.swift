//
//  CatFactsDomain.swift
//  CatFactsDomain
//
//  Created by Vasnev Anton Mikhaylovich on 17.04.2022.
//  Copyright © 2022 CatFacts.io. All rights reserved.
//

import Foundation

/// Bounded context with CatFacts Buisiness Logic
public enum CatFactsDomain {

	// MARK: Type System

	public typealias CatFact = String

	// MARK: State

	public struct State {

		public static var initial: Self { .init(catFacts: []) }

		public var catFacts: [CatFact]
	}

	// MARK: Input

	public enum Input {
		case catFactDemand
		case networkRespondedWithCatFact(CatFact)
	}

	// MARK: Output

	public enum Output {
		case confirmMoreCatFactssDemand
		case requestCatFactsFromNetwork
	}

	// MARK: Update

	public static func update(_ state: inout State, with input: Input) -> [Output] {
		switch input {
		case .catFactDemand:
			return [.requestCatFactsFromNetwork]
		case .networkRespondedWithCatFact(let newCatFact):
			state.catFacts.append(newCatFact)
			return [.confirmMoreCatFactssDemand]
		}
	}
}
