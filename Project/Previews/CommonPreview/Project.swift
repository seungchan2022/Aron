import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .preview(
  projectName: "Common",
  packages: [
    .local(path: "../../../Modules/Core/Architecture"),
    .local(path: "../../../Modules/Core/DesignSystem"),
    .local(path: "../../../Modules/Core/Domain"),
    .local(path: "../../../Modules/Core/Platform"),
    .local(path: "../../../Modules/Core/Functor"),
    .package(path: "../../../Modules/Feature/Common"),
  ],
  dependencies: [
    .package(product: "Common", type: .runtime),
  ])
