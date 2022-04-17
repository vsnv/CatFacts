import ProjectDescription

public enum Module: String, CaseIterable {
	case CatFactApp
	case CatFactDomain
	case CatFactUI
	case CatFactNetworkService

	var name: String { rawValue }

	var platform: Platform { .iOS }

	var bundleIDPrefix: String { "io.CatFacts" }

	var internalDependencies: [Module] {
		switch self {
		case .CatFactApp:
			return [
				.CatFactDomain,
				.CatFactUI,
				.CatFactNetworkService
			]
		case .CatFactDomain, .CatFactUI, .CatFactNetworkService:
			return []
		}
	}

	var targets: [Target] {
		switch self {
		case .CatFactApp:
			return makeAppTargets(
				name: name,
				platform: platform,
				dependencies: [
					.target(name: Module.CatFactDomain.name),
					.target(name: Module.CatFactUI.name),
					.target(name: Module.CatFactNetworkService.name),
				]
			)
		case .CatFactDomain, .CatFactUI, .CatFactNetworkService:
			return makeFrameworkTargets(
				name: name,
				platform: platform
			)
		}
	}

	// MARK: - Private

	/// Helper function to create a framework target and an associated unit test target
	private func makeFrameworkTargets(name: String, platform: Platform) -> [Target] {
		let sources = Target(name: name,
												 platform: platform,
												 product: .framework,
												 bundleId: "\(bundleIDPrefix).\(name)",
												 infoPlist: .default,
												 sources: ["Targets/\(name)/Sources/**"],
												 resources: [],
												 dependencies: [])
		let tests = Target(name: "\(name)Tests",
											 platform: platform,
											 product: .unitTests,
											 bundleId: "\(bundleIDPrefix).\(name)Tests",
											 infoPlist: .default,
											 sources: ["Targets/\(name)/Tests/**"],
											 resources: [],
											 dependencies: [.target(name: name)])
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
			infoPlist: .default,
			sources: ["Targets/\(name)/Tests/**"],
			dependencies: [
				.target(name: "\(name)")
			])
		return [mainTarget, testTarget]
	}
}

extension Project {
	public static func app(name: String) -> Project {
		Project(
			name: name,
			organizationName: "CatFacts.io",
			targets: Module.allCases.flatMap { $0.targets }
		)
	}
}
