//
//  SearchView.swift
//  Dolanan.id myGameCatalogue
//
//  Created by Dimas Putro on 21/11/21.
//

import SwiftUI
import Core
import Game
import Common

struct SearchGameView: View {
  
  @ObservedObject var searchGamePresenter: GetListPresenter<String, GameDomainModel, Interactor<String, [GameDomainModel], GetGamesRepository<GetGamesLocaleDataSource, GetGamesRemoteDataSource, GameTransformer>>>
  
  @State private var isEditing: Bool = false
  @State var photoProfileUser: Data = Data()
  @State private var topRatingGames: [TopRatingGamesModel] = []
  
  var body: some View {
    NavigationView {
      GeometryReader { geometry in
        ScrollView(showsIndicators: false) {
          VStack(alignment: .leading) {
            HStack {
              TextField("\(LocalizedLang.search) game", text: $searchGamePresenter.keywordCounter)
                .onReceive(searchGamePresenter.$keywordCounter.debounce(for: .seconds(0.3), scheduler: DispatchQueue.main)) {
                  guard !$0.isEmpty else { return }
                  
                  if $0.count >= 3 {
                    self.searchGamePresenter.getList(request: $0)
                  }
                }
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                  HStack {
                    Image(systemName: "magnifyingglass")
                      .foregroundColor(.gray)
                      .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                      .padding(.leading, 8)
                    
                    if isEditing {
                      Button(action: {
                        searchGamePresenter.keywordCounter = ""
                        searchGamePresenter.list = []
                      }) {
                        Image(systemName: "multiply.circle.fill")
                          .foregroundColor(.gray)
                          .padding(.trailing, 8)
                      }
                    }
                  }
                )
                .onTapGesture {
                  self.isEditing = true
                }
                .animation(.default)
                .keyboardType(.webSearch)
              
              if isEditing {
                Button(action: {
                  self.isEditing = false
                  searchGamePresenter.keywordCounter = ""
                  searchGamePresenter.list = []
                  
                  // Dismiss the keyboard
                  UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                  Text(LocalizedLang.cancel)
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
              }
            }
            
            if searchGamePresenter.keywordCounter == "" {
              VStack(alignment: .leading) {
                Text(LocalizedLang.topRateGame)
                  .font(.title2)
                  .bold()
                  .padding(.top, 40)
                  .padding(.leading, 15)
                
                List {
                  ForEach(self.topRatingGames, id: \.id) { game in
                    HStack {
                      Text(game.title ?? "")
                        .foregroundColor(.accentColor)
                      Spacer()
                      
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                      self.isEditing = true
                      self.searchGamePresenter.keywordCounter = game.title ?? ""
                      self.searchGamePresenter.getList(request: game.title ?? "")
                    }
                  }
                }
                .listStyle(PlainListStyle())
                
              }
              .frame(height: geometry.size.height)
              .padding(.leading, -20)
            } else {
              if searchGamePresenter.isLoading {
                loadingIndicator
              } else {
                if searchGamePresenter.list.isEmpty {
                  resultEmptyContent
                } else {
                  resultSearchContent
                }
              }
            }
          }
          .padding(.leading, 18)
          .padding(.trailing, 18)
        }
        .onAppear {
          self.fetchTopRatingGames()
          
          photoProfileUser = UserDefaults.standard.data(forKey: "PhotoProfileUser") ?? Data()
        }
        .padding(.bottom, 10)
        .navigationTitle(LocalizedLang.search)
        .navigationBarItems(trailing:
                              self.profileLinkBuilder {
          ProfilePictureNavbar(profileImageData: photoProfileUser)
        }
        )
      }
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }
}

extension SearchGameView {
  
  private var loadingIndicator: some View {
    LoadingIndicator()
  }
  
  private var resultEmptyContent: some View {
    HStack(alignment: .center) {
      VStack(alignment: .center) {
        Spacer()
        Image(systemName: "questionmark.folder")
          .resizable()
          .frame(width: 36, height: 30)
          .foregroundColor(.gray)
        Text(LocalizedLang.dataNotFound).font(.callout).foregroundColor(.gray).padding(.top, 5)
        Spacer()
      }
      .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2, alignment: .center)
    }.frame(width: UIScreen.main.bounds.width)
  }
  
  private var resultSearchContent: some View {
    VStack {
      ForEach(searchGamePresenter.list, id: \.id) { game in
        self.detailGameLinkBuilder(id: game.id ?? 0) {
          SearchGameCard(game: game)
            .padding(.bottom, 20)
        }
      }
    }
  }
  
  private func fetchTopRatingGames() {
    self.topRatingGames = dataTopRatingGames
  }
  
  func detailGameLinkBuilder<Content: View>(
    id: Int,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(destination: SearchGameRouter().makeDetailView(id: id)) { content() }
  }
  
  func profileLinkBuilder<Content: View>(
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(destination: SearchGameRouter().makeProfileView()) { content() }
  }
}
