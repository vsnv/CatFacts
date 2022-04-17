//
//  CatFactNetworkError.swift
//  CatFactNetworkService
//
//  Created by Vasnev Anton Mikhaylovich on 17.04.2022.
//  Copyright © 2022 CatFacts.io. All rights reserved.
//

import Foundation

public enum CatFactNetworkError: Error {
	case failedToMakeRequestURL
	case failedToDecode(underlyingError: Error)
	case requestError(underlyingError: Error)
	case noData
}
