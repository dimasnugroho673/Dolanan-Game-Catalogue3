//
//  PopularGameCard2.swift
//  Dolanan.id myGameCatalogue
//
//  Created by Dimas Putro on 24/11/21.
//

import SwiftUI
import SDWebImageSwiftUI
import Game

struct PopularGameCard2: View {

  var game: GameDomainModel
  var isLastItem: Bool = false
  
  var body: some View {
//    Spacer()
//    Spacer()
    HStack(alignment: .top) {
      WebImage(url: URL(string: game.backgroundImage ?? ""))
        .resizable()
        .renderingMode(.original)
        .aspectRatio(contentMode: .fill)
        .frame(width: 130, height: 80)
        .clipped()
        .cornerRadius(5)

      VStack(alignment: .leading, spacing: 0) {
        Text(game.name ?? "")
          .foregroundColor(.primary)
          .font(.headline)

        if game.genres?.isEmpty != nil {
          Text(game.genres!
                .map {
            $0.name
          }
            .joined(separator: ", "))
            .foregroundColor(.gray)
            .font(.caption)
            .frame(maxWidth: 220, maxHeight: 20, alignment: .leading)
        }

        HStack(spacing: 3) {
          ForEach(1...5, id: \.self) { index in
            Image(systemName: index > Int(round(game.rating ?? 0.0)) ? "star" : "star.fill")
              .resizable()
              .foregroundColor(Color.gray)
              .frame(width: 12, height: 12)
          }

          Text("\(game.rating?.clean ?? "")")
            .font(.caption)
            .foregroundColor(.gray)
            .padding(.leading, 3)
            .padding(.top, 2)
        }
      }
    }
//    Spacer()
//    Spacer()
  }
}
