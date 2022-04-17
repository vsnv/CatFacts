//
//  CatFactDomain.swift
//  CatFactDomain
//
//  Created by Vasnev Anton Mikhaylovich on 17.04.2022.
//  Copyright © 2022 CatFact.io. All rights reserved.
//

import Foundation

/// Bounded context with CatFact Buisiness Logic
public enum CatFactDomain {

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
		case apiRespondedWithCatFact(CatFact)
	}

	// MARK: Output

	public enum Output {
		case confirmMoreCatFactsDemand
		case requestCatFactFromNetwork
	}

	// MARK: Update

	public static func update(_ state: inout State, with input: Input) -> [Output] {
		switch input {
		case .catFactDemand:
			return [.requestCatFactFromNetwork]
		case .apiRespondedWithCatFact(let newCatFact):
			state.catFacts.append(newCatFact)
			return [.confirmMoreCatFactsDemand]
		}
	}
}
