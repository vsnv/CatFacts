//
//  GetCatFactFromNetworkPerformer.swift
//  CatFactApp
//
//  Created by Vasnev Anton Mikhaylovich on 17.04.2022.
//  Copyright © 2022 CatFacts.io. All rights reserved.
//

import Foundation
import CatFactNetworkService

enum GetCatFactFromNetworkPerformer {
	static func perform(
		getFact: (@escaping (Result<CatFactNetworkResponse, CatFactNetworkError>) -> Void) -> Void,
		dispatch: @escaping App.Dispatch
	) {
		getFact { result in
			switch result {
			case .success(let catFactResponse):
				dispatch(.domainInput(.apiRespondedWithCatFact(catFactResponse.fact)))
			case .failure(let error):
				fatalError(error.localizedDescription)
			}
		}
	}
}
