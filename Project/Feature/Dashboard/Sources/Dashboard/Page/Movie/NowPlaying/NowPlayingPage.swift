import SwiftUI
import ComposableArchitecture

struct NowPlayingPage {
  @Bindable var store: StoreOf<NowPlayingReducer>
  
  @State private var searchResult: SearchResult = .movie
  
}

extension NowPlayingPage {
  
  private var itemListComponentViewState: [ItemComponent.ViewState] {
    [
      .init(
        title: "듄: 파트 2",
        voteAverage: 8.406,
        releaseDate: "2024-03-01",
        overView: "황제의 모략으로 멸문한 가문의 유일한 후계자 폴. 어머니 레이디 제시카와 간신히 목숨만 부지한 채 사막으로 도망친다. 그곳에서 만난 반란군들과 숨어 지내다 그들과 함께 황제의 모든 것을 파괴할 전투를 준비한다. 한편 반란군들의 기세가 높아질수록 불안해진 황제와 귀족 가문은 잔혹한 암살자 페이드 로타를 보내 반란군을 몰살하려 하는데…"),
      .init(
        title: "No Way Up",
        voteAverage: 6.073,
        releaseDate: "2024-02-16",
        overView: ""),
      .init(
        title: "랜드 오브 배드",
        voteAverage: 6.995,
        releaseDate: "2024-02-16",
        overView: "라스베이거스 공군 기지의 베테랑 드론 조종사 리퍼(러셀 크로우)는 델타포스 티어-원 부대의 CIA 요원 구출작전 지원임무를 맡게 된다. 슈가(마일로 벤티밀리아), 아벨(루크 헴스워스)이 이끄는 티어-원 부대는 CIA 요원이 사라진 필리핀 남서부, 미스터리한 지형의 홀로 섬 정찰에 나서고, 이 위험천만한 작전을 위해 JTAC 신입요원 키니(리암 헴스워스)와 실전 경험이 많은 군인 비숍(리키 휘틀)까지 합류한다. 그러나 도망칠 곳도 숨을 곳도 없는 섬에서 이들은 곧 적에게 노출되고 피할 수 없는 전면전이 펼쳐지며 상황은 급반전을 맞이한다. 무기도, 통신장비도 없는 정글에 홀로 갇힌 키니, 동료를 구하고 작전을 성공시켜야 할 그에게 남은 건, 눈과 귀가 되어주는 드론 조종사 리퍼뿐! 누구도 포기하지 않는다, 끝까지 살아남는다!"),
      .init(
        title: "페이크 러브",
        voteAverage: 7.048,
        releaseDate: "2023-12-22",
        overView: ""),
      .init(
        title: "듄",
        voteAverage: 7.788,
        releaseDate: "2024-02-09",
        overView: "10191년, 아트레이데스 가문의 후계자인 폴은 시간과 공간을 초월해 과거와 미래를 모두 볼 수 있고, 더 나은 미래를 만들 유일한 구원자인 예지된 자의 운명을 타고났다. 그리고 어떤 계시처럼 매일 꿈에서 아라키스의 행성에 있는 한 여인을 만난다. 귀족들이 지지하는 아트레이데스 가문에 대한 황제의 질투는 폴과 그 일족들을 죽음이 기다리는 아라키스로 이끄는데...")
      
    ]
  }
}

extension NowPlayingPage: View {
  var body: some View {
    ScrollView {
      SearchComponent(
        viewState: .init(),
        store: store)
      
      
      // query에 따라서 보이는 Component 다르게
      
      if store.query.isEmpty {
        // MovieItemComponent
        LazyVStack(spacing: 16) {
          ForEach(itemListComponentViewState, id: \.title) { item in
            ItemComponent(
              viewState: item,
              tapAction: {  })
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
