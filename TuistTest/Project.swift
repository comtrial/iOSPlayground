import ProjectDescription

let project = Project.app(name: "TuistTest",
                          platform: .iOS,
                          additionalTargets: ["TuistTestAppKit", "TuistTestAppUI"])

