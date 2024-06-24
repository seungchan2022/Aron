import ComposableArchitecture
import DesignSystem
import SwiftUI

// MARK: - SettingPage

struct SettingPage {
  @Bindable var store: StoreOf<SettingReducer>
  let scheme: ColorScheme

  @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
  @Namespace private var animation
}

// MARK: View

extension SettingPage: View {
  var body: some View {
    VStack(spacing: 15) {
      Image(systemName: scheme == .dark ? "moon.fill" : "sun.max")
        .resizable()
        .frame(width: 150, height: 150)
        .foregroundStyle(userTheme.color(scheme: scheme).gradient)
        .animation(.easeInOut(duration: 0.4), value: scheme)
        .animation(.easeInOut(duration: 0.4), value: userTheme)

      Text("Choose a Style")
        .font(.title2)
        .fontWeight(.bold)
        .padding(.top, 25)

      Text("Pop or subtle, Day or night. \nCustomize your interface.")
        .multilineTextAlignment(.center)

      HStack(spacing: .zero) {
        ForEach(Theme.allCases, id: \.rawValue) { item in
          Text(item.rawValue)
            .padding(.vertical, 10)
            .frame(width: 100)
            .background {
              ZStack {
                if userTheme == item {
                  Capsule()
                    .fill(DesignSystemColor.background(.theme).color)
                    .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                }
              }
              .animation(.snappy, value: userTheme)
            }
            .contentShape(.rect)
            .onTapGesture {
              userTheme = item
            }
        }
      }
      .padding(4)
      .background(.primary.opacity(0.06), in: .capsule)
      .padding(.top, 20)
    }

    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .frame(height: 410)
    .background(DesignSystemColor.background(.theme).color)
    .clipShape(.rect(cornerRadius: 30))
    .padding(.horizontal, 15)
    .environment(\.colorScheme, scheme)
    .onAppear { }
    .onDisappear {
      store.send(.teardown)
    }
  }
}

// MARK: - Theme

/// Theme
enum Theme: String, CaseIterable, Equatable {
  case systemDefault = "Default"
  case light = "Light"
  case dark = "Dark"

  // MARK: Internal

  var colorScheme: ColorScheme? {
    switch self {
    case .systemDefault:
      return .none
    case .light:
      return .light
    case .dark:
      return .dark
    }
  }

  func color(scheme: ColorScheme) -> Color {
    switch self {
    case .systemDefault:
      return scheme == .dark ? .purple : .orange
    case .light:
      return .orange
    case .dark:
      return .purple
    }
  }
}
