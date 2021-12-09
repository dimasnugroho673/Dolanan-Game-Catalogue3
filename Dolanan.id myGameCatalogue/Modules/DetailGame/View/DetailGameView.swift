//
//  DetailGameView.swift
//  Dolanan.id myGameCatalogue
//
//  Created by Dimas Putro on 21/11/21.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI
import Game
import Core

struct GameDetailView: View {
  
  @Environment(\.presentationMode) var presentation
  @Environment(\.openURL) var openURL
  @Environment(\.colorScheme) var colorScheme
  
  var id: Int?

  //  @ObservedObject var detailPresenter: GetDetailPresenter<Int, GameDetailDomainModel, Interactor<Int, GameDetailDomainModel, GetGameRepository<GetGamesLocaleDataSource, GetGameRemoteDataSource, GameTransformer>>>

  @ObservedObject var detailPresenter: GameDetailPresenter<
    Interactor<Int, GameDetailDomainModel, GetGameRepository<GetGamesLocaleDataSource, GetGameRemoteDataSource, GameTransformer>>,
    Interactor<GameDomainModel, Bool, UpdateFavoriteGameRepository<GetGamesLocaleDataSource, GameTransformer>>
  >

  @State var isFavorite: Bool = false
  
  let hapticFeebackMedium = UIImpactFeedbackGenerator(style: .medium)
  
  var body: some View {
    
    if detailPresenter.errorMessage != "" {
      HStack(alignment: .center) {
        Spacer()
        VStack {
          Spacer()
          Image(systemName: "exclamationmark.icloud")
            .resizable()
            .frame(width: 42, height: 30)
            .foregroundColor(.gray)
          Text("Terjadi kesalahan pada server").font(.body).foregroundColor(.gray).padding(.top, 5)
          Spacer()
        }
        Spacer()
      }.frame(width: UIScreen.main.bounds.width)
    } else {
      ScrollView(.vertical, showsIndicators: false) {
        GeometryReader { reader in
          WebImage(url: URL(string: detailPresenter.detail?.backgroundImage ?? ""))
            .resizable()
            .aspectRatio(contentMode: .fill)
            .offset(y: -reader.frame(in: .global).minY)
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width, height: reader.frame(in: .global).minY + 480)
        }
        .frame(height: 480)
        
        VStack(alignment: .leading, spacing: 15) {
          Text(detailPresenter.detail?.name ?? "")
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(colorScheme == .light ? .black : .white)
            .padding(.top, 5)
          
          Text(detailPresenter.detail?.genres?.map {
            $0.name
          }.joined(separator: ", ") ?? "")
            .font(.callout)
            .foregroundColor(Color.init(.systemGray))
            .padding(.top, -10)

          if detailPresenter.detail?.backgroundImage ?? "" != "" {
            if isFavorite {
              Button(action: {
                removeFavoriteButtonTap()
              }) {
                HStack {
                  Text("Remove")
                    .font(.body)
                    .fontWeight(.bold)
                  Image(systemName: "star.fill")
                }
              }.buttonStyle(RemoveBookmarkButtonStyle())
            } else {
              Button(action: {
                addFavoriteButtonTap()
                hapticFeebackMedium.impactOccurred()
              }) {
                HStack {
                  Text("Favorite")
                    .font(.body)
                    .fontWeight(.bold)
                  Image(systemName: "star")
                }
              }.buttonStyle(AddBookmarkButtonStyle())
            }
          }
          
          Text("Rating")
            .font(.system(size: 20, weight: .bold))
            .foregroundColor(colorScheme == .light ? .black : .white)
            .padding(.top, 20)
          
          HStack(spacing: 3) {
            ForEach(1...5, id: \.self) { index in
              Image(systemName: index > Int(round(detailPresenter.detail?.rating ?? 0.0)) ? "star" : "star.fill")
                .foregroundColor(Color.init(.systemYellow))
            }
          }
          .padding(.top, 0)
          
          Text("Description")
            .font(.system(size: 20, weight: .bold))
            .foregroundColor(colorScheme == .light ? .black : .white)
            .padding(.top, 5)
          
          Text(detailPresenter.detail?.descriptionRaw ?? "")
            .font(.subheadline)
            .foregroundColor(colorScheme == .light ? Color.black : Color.white)
          
          Text("Information")
            .font(.system(size: 20, weight: .bold))
            .foregroundColor(colorScheme == .light ? .black : .white)
            .padding(.top, 5)
          
          List {
            HStack {
              Text("Relased Date")
                .foregroundColor(.gray)
                .font(.subheadline)
              Spacer()
              Text(detailPresenter.detail?.released?.formatterDate(dateInString: detailPresenter.detail?.released ?? "", inFormat: "yyy-MM-dd", toFormat: "dd MMM yyyy") ?? "")
                .font(.subheadline)
            }
            
            HStack {
              Text("Age Rating")
                .foregroundColor(.gray)
                .font(.subheadline)
              Spacer()
              Text(detailPresenter.detail?.ageRating?.name ?? "")
                .font(.subheadline)
            }
            
            HStack {
              Text("Platform")
                .foregroundColor(.gray)
                .font(.subheadline)
              Spacer()
              Text(detailPresenter.detail?.parentPlatforms?.map { $0.childPlatform.name }.joined(separator: ", ") ?? "")
                .font(.subheadline)
            }
            
            HStack {
              Text("Playtime")
                .foregroundColor(.gray)
                .font(.subheadline)
              Spacer()
              Text("\(detailPresenter.detail?.playtime ?? 0) Hour")
                .font(.subheadline)
            }
            
            HStack {
              Text("Developer Website")
                .foregroundColor(.accentColor)
                .font(.subheadline)
                .onTapGesture {
                  openURL(URL(string: detailPresenter.detail?.website ?? "")!)
                }
              Spacer()
              Text(Image(systemName: "safari"))
                .font(.subheadline)
                .foregroundColor(.accentColor)
                .onTapGesture {
                  openURL(URL(string: detailPresenter.detail?.website ?? "")!)
                }
            }
            
            HStack {
              Text("View all reviews")
                .foregroundColor(.accentColor)
                .font(.subheadline)
                .onTapGesture {
                  openURL(URL(string: detailPresenter.detail?.metacriticURL ?? "")!)
                }
              Spacer()
              Text(Image(systemName: "quote.bubble"))
                .font(.subheadline)
                .foregroundColor(.accentColor)
                .onTapGesture {
                  openURL(URL(string: detailPresenter.detail?.metacriticURL ?? "")!)
                }
            }
          }
          .listStyle(PlainListStyle())
          .padding(.leading, -10)
          .frame(width: .infinity, height: 400)
          .onAppear {
            UITableView.appearance().isScrollEnabled = false
          }
        }
        .padding(.top, 25)
        .padding(.horizontal)
        .background(colorScheme == .light ? Color.white : Color.black)
        .cornerRadius(22)
        .offset(y: -35)
      }
      .edgesIgnoringSafeArea(.all)
      .background(colorScheme == .light ? Color.white.edgesIgnoringSafeArea(.all) : Color.black.edgesIgnoringSafeArea(.all))
      .navigationBarBackButtonHidden(true)
      .navigationBarItems(leading:
                            Button(action: {
        self.presentation.wrappedValue.dismiss()
      }) {
        HStack {
          Image(systemName: "chevron.backward.circle.fill")
            .resizable()
            .frame(width: 30, height: 30)
            .foregroundColor(colorScheme == .light ? Color.init(.systemGray) : .white)
        }
      })
      .onAppear {
        detailPresenter.getDetail(request: self.id ?? 0)

        self.isFavorite = detailPresenter.favoriteGames.filter { $0 == self.id ?? 0 }.count > 0
        print("FAVORITE GAMES: \n \(detailPresenter.favoriteGames)")
      }
    }
  }
  
  func addFavoriteButtonTap() {
    detailPresenter.addGameToFavorite(request: GameDomainModel(id: detailPresenter.detail?.id ?? 0, name: detailPresenter.detail?.name ?? "", released: detailPresenter.detail?.released ?? "", backgroundImage: detailPresenter.detail?.backgroundImage ?? "", rating: detailPresenter.detail?.rating ?? 0.0, genres: [], screenshots: []))

    self.isFavorite = true
  }
  
  func removeFavoriteButtonTap() {
    detailPresenter.removeGameFromFavorite(request: GameDomainModel(id: detailPresenter.detail?.id ?? 0, name: detailPresenter.detail?.name ?? "", released: detailPresenter.detail?.released ?? "", backgroundImage: detailPresenter.detail?.backgroundImage ?? "", rating: detailPresenter.detail?.rating ?? 0.0, genres: [], screenshots: []))

    self.isFavorite = false
  }
}
