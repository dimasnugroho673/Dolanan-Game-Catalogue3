//
//  SearchView.swift
//  Dolanan.id myGameCatalogue
//
//  Created by Dimas Putro on 21/11/21.
//

import SwiftUI
import Core
import Game

struct SearchGameView: View {
  
//  @ObservedObject var searchGamePresenter: SearchGamePresenter
  @ObservedObject var searchGamePresenter: GetListPresenter<String, GameDomainModel, Interactor<String, [GameDomainModel], GetGamesRepository<GetGamesLocaleDataSource, GetGamesRemoteDataSource, GameTransformer>>>
  
  @State private var isEditing: Bool = false
  @State private var topRatingGames: [TopRatingGamesModel] = [
    TopRatingGamesModel(title: "Cyberpunk 2077"),
    TopRatingGamesModel(title: "Final Fantasy VII Remake Intergrade"),
    TopRatingGamesModel(title: "Hitman 3"),
    TopRatingGamesModel(title: "Watch Dogs 2"),
    TopRatingGamesModel(title: "Assassin's Creed Valhalla")
  ]
  
  var body: some View {
    NavigationView {
      GeometryReader { geometry in
        ScrollView(showsIndicators: false) {
          VStack(alignment: .leading) {
            HStack {
              TextField("Search game", text: $searchGamePresenter.keywordCounter)
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
                  Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
              }
            }
            
            if searchGamePresenter.keywordCounter == "" {
              VStack(alignment: .leading) {
                Text("Top rate game")
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
                HStack(alignment: .center) {
                  Spacer()
                  VStack {
                    Spacer()
                    LoadingState().padding(.top, 10)
                    Text("LOADING").font(.caption).foregroundColor(.gray).padding(.top, 5)
                    Spacer()
                  }
                  Spacer()
                }.frame(width: .infinity, height: UIScreen.main.bounds.height / 2, alignment: .center)
              } else {
                if searchGamePresenter.list.isEmpty {
                  HStack(alignment: .center) {
                    VStack(alignment: .center) {
                      Spacer()
                      Image(systemName: "questionmark.folder")
                        .resizable()
                        .frame(width: 36, height: 30)
                        .foregroundColor(.gray)
                      Text("Data tidak ditemukan").font(.callout).foregroundColor(.gray).padding(.top, 5)
                      Spacer()
                    }
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2, alignment: .center)
                  }.frame(width: UIScreen.main.bounds.width)
                } else {
                  VStack {
                    ForEach(searchGamePresenter.list, id: \.id) { game in
                      self.detailGameLinkBuilder(id: game.id ?? 0) {
                        SearchGameCard(game: game)
                          .padding(.bottom, 20)
                      }
                    }
                  }
                }
              }
            }
          }
          .padding(.leading, 18)
          .padding(.trailing, 18)
        }
        .onAppear {
//          searchGamePresenter.getTopRatingGames()
//          searchGamePresenter.getUser()
        }
        .padding(.bottom, 10)
        .navigationTitle(searchGamePresenter.list.isEmpty ? "Search" : "Search Results (\(searchGamePresenter.list.count))")
//        .navigationBarItems(trailing:
//                              searchGamePresenter.linkToProfileView {
//          ProfilePictureNavbar(profileImageData: searchGamePresenter.user?.profilePicture ?? Data())
//        }
//        )
      }
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }
}

extension SearchGameView {
  func detailGameLinkBuilder<Content: View>(
    id: Int,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(destination: SearchGameRouter().makeDetailView(id: id)) { content() }
  }
}
