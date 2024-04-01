import ProjectDescription
import ProjectDescriptionHelpers

let targetList: [Target] = [
  .target(
    name: "Aron-Production",
    destinations: .iOS,
    product: .app,
    productName: "Aron",
    bundleId: "io.seungchan.aron.prod",
    deploymentTargets: .default,
    infoPlist: .defaultInfoPlist,
    sources: ["Sources/**"],
    resources: ["Resources/**"],
    copyFiles: .none,
    headers: .none,
    entitlements: .none,
    scripts: [],
    dependencies: [],
    settings: .defaultConfig(false),
    coreDataModels: [],
    environmentVariables: [:],
    launchArguments: [],
    additionalFiles: [],
    buildRules: [],
    mergedBinaryType: .disabled,
    mergeable: false),

  .target(
    name: "Aron-QA",
    destinations: .iOS,
    product: .app,
    productName: "Aron",
    bundleId: "io.seungchan.aron.qa",
    deploymentTargets: .iOS("17.0"),
    infoPlist: .default,
    sources: ["Sources/**"],
    resources: ["Resources/**"],
    copyFiles: .none,
    headers: .none,
    entitlements: .none,
    scripts: [],
    dependencies: [],
    settings: .defaultConfig(true),
    coreDataModels: [],
    environmentVariables: [:],
    launchArguments: [],
    additionalFiles: [],
    buildRules: [],
    mergedBinaryType: .disabled,
    mergeable: false),
]

let project: Project = .init(
  name: "AronApplication",
  organizationName: "SeungChanMoon",
  options: .options(),
  packages: [],
  settings: .settings(),
  targets: targetList,
  schemes: [],
  fileHeaderTemplate: .none,
  additionalFiles: [],
  resourceSynthesizers: [])
