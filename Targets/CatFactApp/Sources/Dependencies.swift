//
//  Dependencies.swift
//  CatFactApp
//
//  Created by Vasnev Anton Mikhaylovich on 17.04.2022.
//  Copyright © 2022 CatFact.io. All rights reserved.
//

import CatFactNetworkService
import UIKit

struct Dependencies {
	let catFactNetworking = CatFactNetworkService()
	var rootViewController: UIViewController?
}
