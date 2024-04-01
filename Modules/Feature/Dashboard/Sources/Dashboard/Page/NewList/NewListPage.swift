import ComposableArchitecture
import DesignSystem
import SwiftUI

// MARK: - NewListPage

struct NewListPage {
  @Bindable var store: StoreOf<NewListReducer>

  @Environment(\.colorScheme) var colorScheme

  @State private var listName = ""
  @State private var listCover = ""
}

extension NewListPage { }

// MARK: View

extension NewListPage: View {
  var body: some View {
    ScrollView {
      VStack {
        // LIST INFORMATION
        VStack(alignment: .leading, spacing: .zero) {
          Text("LIST INFORMATION")
            .font(.system(size: 14, weight: .regular))
            .foregroundStyle(DesignSystemColor.palette(.gray(.lv400)).color)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)

          HStack {
            Text("Name:")
            TextField(
              "",
              text: self.$listName,
              prompt: Text("Name your list"))
          }
          .padding(16)
          .background(
            colorScheme == .dark
              ? DesignSystemColor.background(.black).color
              : DesignSystemColor.system(.white).color)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }

        // LIST COVER
        VStack(alignment: .leading, spacing: .zero) {
          Text("LIST COVER")
            .font(.system(size: 14, weight: .regular))
            .foregroundStyle(DesignSystemColor.palette(.gray(.lv400)).color)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)

          HStack(spacing: 16) {
            Image(systemName: "magnifyingglass")
              .resizable()
              .frame(width: 18, height: 18)
              .symbolRenderingMode(.palette)

            TextField(
              "",
              text: self.$listCover,
              prompt: Text("Search and add a movie cover"))
              .textFieldStyle(.roundedBorder)

            if !self.listCover.isEmpty {
              Button(action: { self.listCover = "" }) {
                Text("Cancel")
                  .foregroundStyle(.red)
              }
            }
          }
          .padding(.trailing, 32)
          .padding(16)
          .background(
            colorScheme == .dark
              ? DesignSystemColor.background(.black).color
              : DesignSystemColor.system(.white).color)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .padding(.vertical, 16)

        // 버튼들
        VStack(alignment: .leading, spacing: 16) {
          Button(action: { store.send(.routeToBack) }) {
            Text("Create")
          }

          Divider()

          Button(action: { store.send(.routeToBack) }) {
            Text("Cancel")
              .foregroundStyle(.red)
          }
        }
        .padding(.vertical, 16)
        .padding(.leading, 16)
        .background(
          colorScheme == .dark
            ? DesignSystemColor.background(.black).color
            : DesignSystemColor.system(.white).color)
          .clipShape(RoundedRectangle(cornerRadius: 10))
          .padding(.top, 16)
      } // 전체 VStack
    }
    .padding(.horizontal, 16)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(
      colorScheme == .dark
        ? DesignSystemColor.system(.black).color
        : DesignSystemColor.palette(.gray(.lv200)).color)
      .navigationTitle("New List")
      .navigationBarTitleDisplayMode(.large)
  }
}
