import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .preview(
  projectName: "Credit",
  packages: [
    .local(path: "../../../Modules/Core/Architecture"),
    .local(path: "../../../Modules/Core/DesignSystem"),
    .local(path: "../../../Modules/Core/Domain"),
    .local(path: "../../../Modules/Core/Platform"),
    .local(path: "../../../Modules/Core/Functor"),
    .package(path: "../../../Modules/Feature/Credit"),
  ],
  dependencies: [
    .package(product: "Credit", type: .runtime),
  ])
