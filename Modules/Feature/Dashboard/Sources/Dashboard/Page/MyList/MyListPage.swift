import ComposableArchitecture
import DesignSystem
import SwiftUI

// MARK: - MyListPage

struct MyListPage {
  @Bindable var store: StoreOf<MyListReducer>

  @State private var listType: ListType = .wishList
  @State private var isShowingConfirmation = false

  @Environment(\.colorScheme) var colorScheme
}

// MARK: View

extension MyListPage: View {
  var body: some View {
    ScrollView {
      // Section1: Custom List 생성
      VStack(alignment: .leading) {
        Text("CUSTOM LISTS")
          .font(.system(size: 14, weight: .regular))
          .foregroundStyle(DesignSystemColor.palette(.gray(.lv400)).color)
          .padding(.horizontal, 16)

        Button(action: { store.send(.routeToNewList) }) {
          HStack {
            Text("Create custom list")
              .foregroundStyle(DesignSystemColor.label(.greenSlate).color)
            Spacer()
          }
        }
        .padding(16)
        .background(
          colorScheme == .dark
            ? DesignSystemColor.background(.black).color
            : DesignSystemColor.system(.white).color)
      }
      .padding(.vertical, 16)
      .padding(.bottom, 16)
      .frame(maxWidth: .infinity)

      // Section2: segmented, 아이템 표현
      VStack {
        Picker(
          "",
          selection: self.$listType)
        {
          Text("Wishlist")
            .tag(ListType.wishList)

          Text("Seenlist")
            .tag(ListType.seenList)
        }
        .pickerStyle(.segmented)
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .background(
          colorScheme == .dark
            ? DesignSystemColor.background(.black).color
            : DesignSystemColor.system(.white).color)

        switch self.listType {
        case .wishList:

          LazyVStack(alignment: .leading, spacing: .zero) {
            Text("1 MOVIES IN WISHLIST")
              .font(.system(size: 14, weight: .regular))
              .foregroundStyle(DesignSystemColor.palette(.gray(.lv400)).color)
              .padding(.horizontal, 16)
              .padding(.vertical, 8)

            ForEach(0..<5, id: \.self) { _ in
              Button(action: { }) {
                VStack {
                  HStack(spacing: 8) {
                    Rectangle()
                      .fill(.gray)
                      .frame(width: 100, height: 160)
                      .clipShape(RoundedRectangle(cornerRadius: 10))

                    VStack(alignment: .leading, spacing: 16) {
                      Text("제목")
                        .font(.system(size: 18))
                        .foregroundStyle(DesignSystemColor.label(.ocher).color)

                      HStack {
                        Text("66%")
                          .font(.system(size: 18))
                          .foregroundStyle(
                            colorScheme == .dark
                              ? DesignSystemColor.system(.white).color
                              : DesignSystemColor.system(.black).color)

                        Text("Feb 14, 2024")
                          .font(.system(size: 16))
                          .foregroundStyle(
                            colorScheme == .dark
                              ? DesignSystemColor.system(.white).color
                              : DesignSystemColor.system(.black).color)
                      }
                      Text("overView")
                        .font(.system(size: 18))
                        .foregroundStyle(DesignSystemColor.palette(.gray(.lv400)).color)
                        .multilineTextAlignment(.leading)
                        .lineLimit(3)
                    }

                    Spacer()

                    Image(systemName: "chevron.right")
                      .resizable()
                      .frame(width: 8, height: 12)
                      .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
                  }
                  .padding(.vertical, 16)
                  .frame(maxWidth: .infinity, alignment: .leading)

                  Divider()
                    .padding(.leading, 120)
                }
              }
            }
            .padding(.horizontal, 16)

            .background(
              colorScheme == .dark
                ? DesignSystemColor.background(.black).color
                : DesignSystemColor.system(.white).color)
          }
          .padding(.top, 16)

        case .seenList:
          LazyVStack(alignment: .leading, spacing: .zero) {
            Text("1 MOVIES IN SEENLIST")
              .font(.system(size: 14, weight: .regular))
              .foregroundStyle(DesignSystemColor.palette(.gray(.lv400)).color)
              .padding(.horizontal, 16)
              .padding(.vertical, 8)

            ForEach(0..<1, id: \.self) { _ in
              Button(action: { }) {
                VStack {
                  HStack(spacing: 8) {
                    Rectangle()
                      .fill(.gray)
                      .frame(width: 100, height: 160)
                      .clipShape(RoundedRectangle(cornerRadius: 10))

                    VStack(alignment: .leading, spacing: 16) {
                      Text("제목")
                        .font(.system(size: 18))
                        .foregroundStyle(DesignSystemColor.label(.ocher).color)

                      HStack {
                        Text("66%")
                          .font(.system(size: 18))
                          .foregroundStyle(
                            colorScheme == .dark
                              ? DesignSystemColor.system(.white).color
                              : DesignSystemColor.system(.black).color)

                        Text("Feb 14, 2024")
                          .font(.system(size: 16))
                          .foregroundStyle(
                            colorScheme == .dark
                              ? DesignSystemColor.system(.white).color
                              : DesignSystemColor.system(.black).color)
                      }

                      Text("overView")
                        .font(.system(size: 18))
                        .foregroundStyle(DesignSystemColor.palette(.gray(.lv400)).color)
                        .multilineTextAlignment(.leading)
                        .lineLimit(3)
                    }

                    Spacer()

                    Image(systemName: "chevron.right")
                      .resizable()
                      .frame(width: 8, height: 12)
                      .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
                  }
                  .padding(.vertical, 16)
                  .frame(maxWidth: .infinity, alignment: .leading)

                  Divider()
                    .padding(.leading, 120)
                }
              }
            }
            .padding(.horizontal, 16)
            .background(
              colorScheme == .dark
                ? DesignSystemColor.background(.black).color
                : DesignSystemColor.system(.white).color)
          }
          .padding(.top, 16)
        }
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(
      colorScheme == .dark ? DesignSystemColor.system(.black).color : DesignSystemColor.palette(.gray(.lv100)).color)
    .navigationTitle("My Lists")
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button(action: { self.isShowingConfirmation = true }) {
          Image(systemName: "line.3.horizontal.decrease.circle")
        }
      }
    }
    .confirmationDialog(
      "",
      isPresented: $isShowingConfirmation)
    {
      Button(action: { }) {
        Text("Sort by added date")
      }

      Button(action: { }) {
        Text("Sort by release date")
      }

      Button(action: { }) {
        Text("Sort by ratings")
      }

      Button(action: { }) {
        Text("Sort by popularity")
      }
    } message: {
      Text("Sort movies by")
    }
  }
}

// MARK: - ListType

enum ListType {
  case wishList
  case seenList
}
