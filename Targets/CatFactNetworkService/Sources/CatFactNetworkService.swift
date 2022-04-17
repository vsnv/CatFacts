//
//  CatFactNetworkService.swift
//  CatFactNetworkService
//
//  Created by Vasnev Anton Mikhaylovich on 17.04.2022.
//  Copyright © 2022 CatFact.io. All rights reserved.
//

import Foundation

/// Implementation of Cat Fact Network Service
public final class CatFactNetworkService {

	// MARK: - Constants

	private enum Constants {
		static let host = "https://catfact.ninja"
	}

	// MARK: - Init

	/// Initialize CatFactNetworking Service
	public init() {}

	// MARK: - Public Methods

	/// Get Cat Fact from CatFact API
	/// - Parameter completion: completion with result of API request
	public func getFact(completion: @escaping (Result<CatFactNetworkResponse, CatFactNetworkError>) -> Void) {
		guard let url = URL(string: "\(Constants.host)/fact") else {
			completion(.failure(.failedToMakeRequestURL))
			return
		}
		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		let task = URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				completion(.failure(.requestError(underlyingError: error)))
			}
			if let data = data {
				do {
					let catFactResponse = try JSONDecoder().decode(CatFactNetworkResponse.self, from: data)
					completion(.success(catFactResponse))
				} catch let decodeError {
					completion(.failure(.failedToDecode(underlyingError: decodeError)))
				}
			} else {
				completion(.failure(.noData))
			}
		}
		task.resume()
	}
}
