import ProjectDescription
import ProjectDescriptionHelpers

extension Project {
	public static func app(name: String) -> Project {
		Project(
			name: name,
			organizationName: "CatFacts.io",
			targets: Module.allCases.flatMap { $0.targets }
		)
	}
}

let project = Project.app(name: "CatFacts")
