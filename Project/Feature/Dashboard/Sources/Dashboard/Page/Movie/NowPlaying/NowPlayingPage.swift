import SwiftUI
import ComposableArchitecture

struct NowPlayingPage {
  @Bindable var store: StoreOf<NowPlayingReducer>
  
  @State private var searchResult: SearchResult = .movie
  
}

extension NowPlayingPage: View {
  var body: some View {
    ScrollView {
      VStack(spacing: 16) {
        Divider()
          .padding(.leading, 16)
        
        // SearchComponent
        HStack(spacing: 16) {
          
          Image(systemName: "magnifyingglass")
            .resizable()
            .frame(width: 18, height: 18)
            .symbolRenderingMode(.palette)
          
          TextField(
            "",
            text: self.$store.query,
            prompt: Text("Search any movies or person")
          )
          .textFieldStyle(.roundedBorder)
          
          if !store.query.isEmpty {
            Button(action: { self.store.query = "" }) {
              Text("Cancel")
                .foregroundStyle(.red)
            }
          }
          
        }
        .padding(.horizontal, 16)
        
        Divider()
          .padding(.leading, 16)
      }
      
      // query에 따라서 보이는 Component 다르게
      
      if store.query.isEmpty {
        // MovieItemComponent
        LazyVStack(spacing: 16) {
          ForEach(0..<5) { _ in
            VStack {
              HStack(spacing: 8) {
                Rectangle()
                  .fill(.gray)
                  .frame(width: 100, height: 160)
                  .clipShape(RoundedRectangle(cornerRadius: 10))
                
                VStack(alignment: .leading, spacing: 16) {
                  Text("이름")
                  
                  HStack {
                    Text("61%")
                    
                    Text("222222")
                  }
                  
                  
                  Text("마침내 내면의 평화… 냉면의 평화…가 찾아왔다고 믿는 용의 전사 ‘포’ 이젠 평화의 계곡의 영적 지도자가 되고, 자신을 대신할 후계자를 찾아야만 한다. “이제 용의 전사는 그만둬야 해요?” 용의 전사로의 모습이 익숙해지고 새로운 성장을 하기보다 지금 이대로가 좋은 ‘포’ 하지만 모든 쿵푸 마스터들의 능력을 그대로 복제하는 강력한 빌런 ‘카멜레온’이 나타나고 그녀를 막기 위해 정체를 알 수 없는 쿵푸 고수 ‘젠’과 함께 모험을 떠나게 되는데… 포는 가장 강력한 빌런과 자기 자신마저 뛰어넘고 진정한 변화를 할 수 있을까?")
                    .lineLimit(3)
                  
                }
                
                Image(systemName: "chevron.right")
                  .resizable()
                  .frame(width: 8, height: 12)
                  .foregroundStyle(.gray)
              }
              Divider()
                .padding(.leading, 120)
            }
          }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
        .padding(.top, 12)
      } else {
        VStack {
          Picker(
            "",
            selection: self.$searchResult) {
              Text("Movie")
                .tag(SearchResult.movie)
              
              Text("People")
                .tag(SearchResult.person)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 16)
          
          Divider()
            .padding(.leading, 16)
        
          switch self.searchResult {
          case .movie:
            LazyVStack(spacing: .zero) {
              ForEach(0..<5) { _ in
                Text("movie")
                
                Divider()
                  .padding(.leading, 16)
              }
            }
            
          case .person:
            LazyVStack(spacing: .zero) {
              ForEach(0..<5) { _ in
              Text("person")
                Divider()
                  .padding(.leading, 16)
              }
            }
          }
        }
      }
    }
    .navigationTitle("Now Playing")
    .navigationBarTitleDisplayMode(.inline)
    .scrollDismissesKeyboard(.immediately)
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button(action: { }) {
          Image(systemName: "rectangle.3.group.fill")
        }
      }
      
      ToolbarItem(placement: .topBarTrailing) {
        Button(action: { }) {
          Image(systemName: "gearshape")
        }
      }
    }
  }
}

enum SearchResult {
  case movie
  case person
}
