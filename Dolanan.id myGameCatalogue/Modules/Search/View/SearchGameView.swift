//
//  SearchView.swift
//  Dolanan.id myGameCatalogue
//
//  Created by Dimas Putro on 21/11/21.
//

import Foundation
import SwiftUI

struct SearchGameView: View {
  
  @ObservedObject var searchGamePresenter: SearchGamePresenter
  
  @State private var isEditing = false
  
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
                    self.searchGamePresenter.getGamesByKeyword(keyword: $0)
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
                        searchGamePresenter.resultGames = []
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
                  searchGamePresenter.resultGames = []
                  
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
                  ForEach(searchGamePresenter.topRatingGames, id: \.id) { game in
                    HStack {
                      Text(game.title ?? "")
                        .foregroundColor(.accentColor)
                      Spacer()
                      
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                      self.isEditing = true
                      self.searchGamePresenter.keywordCounter = game.title ?? ""
                      self.searchGamePresenter.getGamesByKeyword(keyword: game.title ?? "")
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
                if searchGamePresenter.resultGames.isEmpty {
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
                    ForEach(searchGamePresenter.resultGames, id: \.id) { game in
                      searchGamePresenter.linkBuilder(for: game) {
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
          searchGamePresenter.getTopRatingGames()
          searchGamePresenter.getUser()
        }
        .padding(.bottom, 10)
        .navigationTitle("Search")
        .navigationBarItems(trailing:
                              searchGamePresenter.linkToProfileView {
          ProfilePictureNavbar(profileImageData: searchGamePresenter.user?.profilePicture ?? Data())
        }
        )
      }
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }
}
