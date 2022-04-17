//
//  Dependencies.swift
//  CatFactsApp
//
//  Created by Vasnev Anton Mikhaylovich on 17.04.2022.
//  Copyright © 2022 CatFacts.io. All rights reserved.
//

import CatFactsNetworkService
import UIKit

struct Dependencies {
	let catFactsNetworkService = CatFactsNetworkService()
	var rootViewController: UIViewController?
}
