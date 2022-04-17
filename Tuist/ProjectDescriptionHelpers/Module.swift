//
//  Module.swift
//  ProjectDescriptionHelpers
//
//  Created by Vasnev Anton Mikhaylovich on 17.04.2022.
//

import ProjectDescription

public enum Module: String, CaseIterable {
	case CatFactsApp
	case CatFactsDomain
	case CatFactsUI
	case CatFactsNetworkService

	var name: String { rawValue }

	var platform: Platform { .iOS }

	var deploymentTarget: DeploymentTarget { .iOS(targetVersion: "12.0", devices: .iphone) }

	var bundleIDPrefix: String { "io.CatFacts" }

	var internalDependencies: [Module] {
		switch self {
		case .CatFactsApp:
			return [
				.CatFactsDomain,
				.CatFactsUI,
				.CatFactsNetworkService
			]
		case .CatFactsDomain, .CatFactsUI, .CatFactsNetworkService:
			return []
		}
	}

	public var targets: [Target] {
		switch self {
		case .CatFactsApp:
			return makeAppTargets(
				name: name,
				platform: platform,
				dependencies: [
					.target(name: Module.CatFactsDomain.name),
					.target(name: Module.CatFactsUI.name),
					.target(name: Module.CatFactsNetworkService.name),
				]
			)
		case .CatFactsDomain, .CatFactsUI, .CatFactsNetworkService:
			return makeFrameworkTargets(
				name: name,
				platform: platform
			)
		}
	}

	// MARK: - Private

	/// Helper function to create a framework target and an associated unit test target
	private func makeFrameworkTargets(name: String, platform: Platform) -> [Target] {
		let sources = Target(
			name: name,
			platform: platform,
			product: .framework,
			bundleId: "\(bundleIDPrefix).\(name)",
			deploymentTarget: deploymentTarget,
			infoPlist: .default,
			sources: ["Targets/\(name)/Sources/**"],
			resources: [],
			dependencies: []
		)
		let tests = Target(
			name: "\(name)Tests",
			platform: platform,
			product: .unitTests,
			bundleId: "\(bundleIDPrefix).\(name)Tests",
			deploymentTarget: deploymentTarget,
			infoPlist: .default,
			sources: ["Targets/\(name)/Tests/**"],
			resources: [],
			dependencies: [.target(name: name)]
		)
		return [sources, tests]
	}

	private func makeAppTargets(name: String, platform: Platform, dependencies: [TargetDependency]) -> [Target] {
		let platform: Platform = platform
		let infoPlist: [String: InfoPlist.Value] = [
			"CFBundleShortVersionString": "1.0",
			"CFBundleVersion": "1",
			"UIMainStoryboardFile": "",
			"UILaunchStoryboardName": "LaunchScreen"
		]

		let mainTarget = Target(
			name: name,
			platform: platform,
			product: .app,
			bundleId: "\(bundleIDPrefix).\(name)",
			deploymentTarget: deploymentTarget,
			infoPlist: .extendingDefault(with: infoPlist),
			sources: ["Targets/\(name)/Sources/**"],
			resources: ["Targets/\(name)/Resources/**"],
			dependencies: dependencies
		)

		let testTarget = Target(
			name: "\(name)Tests",
			platform: platform,
			product: .unitTests,
			bundleId: "\(bundleIDPrefix).\(name)Tests",
			deploymentTarget: deploymentTarget,
			infoPlist: .default,
			sources: ["Targets/\(name)/Tests/**"],
			dependencies: [
				.target(name: "\(name)")
			])
		return [mainTarget, testTarget]
	}
}
