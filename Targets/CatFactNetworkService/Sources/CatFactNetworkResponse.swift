//
//  CatFactNetworkResponse.swift
//  CatFactNetworkService
//
//  Created by Vasnev Anton Mikhaylovich on 17.04.2022.
//  Copyright © 2022 tuist.io. All rights reserved.
//

import Foundation

public struct CatFactNetworkResponse: Codable {
	public let fact: String
	public let length: Int

	enum CodingKeys: String, CodingKey {
		case fact = "fact"
		case length = "length"
	}
}
